require File.expand_path('../../test_helper', __FILE__)

class WatchersControllerTest < ActionController::TestCase
  fixtures :projects,
           :users,
           :groups_users,
           :roles,
           :members,
           :member_roles,
           :issues,
           :issue_statuses,
           :versions,
           :trackers,
           :projects_trackers,
           :issue_categories,
           :enabled_modules,
           :enumerations

  include Redmine::I18n

  def setup
    @controller = WatchersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @user = User.find(2)
    @project = Project.find(1)
    User.current = @user
    @request.session[:user_id] = 2
  end

  def test_users
    users = construct_users_list.to_json
    xhr :get,
        :autocomplete_for_project,
        :project_id => @project.identifier
    assert_response :success
    assert_equal users, @response.body
  end

  def test_autocomplete_by_login
    user = User.find(3)
    users = construct_users_list(user.login).to_json
    xhr :get,
        :autocomplete_for_project,
        :project_id => @project.identifier,
        :term => user.login
    assert_response :success
    assert_equal users, @response.body
  end

  def construct_users_list(term = nil)
    users = User.active.like(term).limit(100).sort
    members, non_members = users.partition { |u| @project.visible?(u) }
    results = members.map { |u| { :id => u.id, :text => u.name } }
    results << {
        :text => l(:label_role_non_member),
        :children => non_members.map do |watcher|
          { :id => watcher.id, :text => watcher.name }
        end
    } if non_members.any?
    {
        :more => false,
        :results => results
    }
  end

end
