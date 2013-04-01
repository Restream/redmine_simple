class AssigneesController < ApplicationController
  before_filter :find_project_by_project_id
  before_filter :authorize
  layout false

  def autocomplete
    @assignees = find_assignable_users_like(params[:term])
    @assignees.insert(0,
        { label: "<< #{l(:label_me)} >>",
          value: User.current.id }) if @assignees.include?(User.current)
  end

  private

  def find_assignable_users_like(q)
    users = @project.assignable_users
    users << User.current if User.current
    users = users.uniq.sort
    return users if q.blank?

    q_users_ids = User.like(q).pluck(:id)
    users.find_all do |u|
      if u.is_a?(Group)
        u.name.downcase.include?(q.to_s.downcase)
      else
        q_users_ids.include?(u.id)
      end
    end
  end
end
