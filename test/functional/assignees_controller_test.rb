require File.expand_path('../../test_helper', __FILE__)

class AssigneesControllerTest < ActionController::TestCase
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
    @controller = AssigneesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @user = User.find(2)
    @project = Project.find(1)
    User.current = @user
    @request.session[:user_id] = 2
  end

  def test_autocomplete
    assignees = construct_assignees_list(@user)
    xhr :get, :autocomplete, :project_id => @project.id
    assert_response :success
    assert_equal assignees.to_json, @response.body
  end

  def test_autocomplete_by_login
    user = User.find(3)
    assignees = { :more => false, :results => [{ :id => user.id, :text => user.name }]}
    xhr :get, :autocomplete, :project_id => @project.id, :term => user.login
    assert_response :success
    assert_equal assignees.to_json, @response.body
  end

  def test_autocomplete_by_name_parts
    user = User.find(3) # Dave Lopper
    assignees = { :more => false, :results => [{ :id => user.id, :text => user.name }]}
    xhr :get, :autocomplete, :project_id => @project.id, :term => "  lop   dav  "
    assert_response :success
    assert_equal assignees.to_json, @response.body
  end

  def construct_assignees_list(current_user)
    # me + sorted users + sorted groups
    # + sorted non_members (if current user can manage members)

    groups, users = @project.assignable_users.sort.partition { |u| u.is_a?(Group) }

    non_members = current_user.allowed_to?(:manage_members, @project) ?
      User.active.not_member_of(@project).sort : []

    {
        :more => false,
        :results =>
            [{ id: @user.id, text: "<< #{l(:label_me)} >>" }] +
            users.map { |u| { :id => u.id, :text => u.name } } +
            (groups.empty? ? [] :
            [{
                :text => l(:label_group),
                :children =>
                    groups.map do |u|
                      { :id => u.id, :text => u.name }
                    end
            }]) +
            (non_members.empty? ? [] :
            [{
                :text => l(:label_role_non_member),
                :children =>
                    non_members.map do |u|
                      { :id => u.id, :text => u.name, :non_member => true }
                    end
            }])
    }
  end

end
