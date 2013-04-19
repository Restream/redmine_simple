class AssigneesController < ApplicationController
  before_filter :find_project_by_project_id
  before_filter :authorize
  layout false

  def autocomplete
    q = format_query(params[:term])
    @users = find_assignable_users_like(q)
    @me = find_me_like(q) if @users.include?(User.current)
    @groups = find_groups_like(q)
    @non_members = find_non_members_like(q)
  end

  private

  def find_assignable_users_like(q)
    users = @project.assignable_users.find_all { |u| u.is_a? User }
    users << User.current if User.current
    users = users.uniq.sort
    return users if q.blank?

    q_users_ids = User.like(q).pluck(:id)
    users.find_all { |u| q_users_ids.include?(u.id) }
  end

  def find_me_like(q)
    me = "<< #{l(:label_me)} >>"
    if q.blank? || me.downcase.include?(q)
      { text: me, id: User.current.id }
    end
  end

  def find_groups_like(q)
    groups = @project.assignable_users.find_all { |g| g.is_a? Group }
    groups = groups.uniq.sort
    return groups if q.blank?

    groups.find_all { |g| g.name =~ /#{q}/i }
  end

  def find_non_members_like(q)
    User.current.allowed_to?(:manage_members, @project) ?
      User.active.like(q).not_member_of(@project).limit(100).sort : []
  end

  def format_query(q)
    unless q.nil?
      q = q.to_s.strip.downcase
      # Take only one space between first name and lastname
      q.sub! /\s{2,}/, ' '
    end
    q
  end
end
