class AssigneesController < ApplicationController
  before_filter :find_project_by_project_id
  before_filter :authorize
  layout false

  def autocomplete
    q = params[:term].to_s.strip.downcase
    @assignees = find_assignable_users_like(q)
    me = "<< #{l(:label_me)} >>"
    if @assignees.include?(User.current) || me.downcase.include?(q)
      @assignees.insert(0, { label: me, value: User.current.id })
    end
  end

  private

  def find_assignable_users_like(q)
    users = @project.assignable_users
    users << User.current if User.current
    users = users.uniq.sort
    return users if q.blank?

    q = $1 if q =~ /#{l(:label_group)}:\s(.+)/i
    q_users_ids = User.like(q).pluck(:id)
    users.find_all do |u|
      if u.is_a?(Group)
        u.name.downcase.include?(q)
      else
        q_users_ids.include?(u.id)
      end
    end
  end
end
