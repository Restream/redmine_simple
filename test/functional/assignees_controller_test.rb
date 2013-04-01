require File.expand_path('../../test_helper', __FILE__)

class AssigneesControllerTest < ActionController::TestCase
  fixtures :projects,
           :users,
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
    assignees = construct_assignees_list
    get :autocomplete, :project_id => @project.id
    assert_response :success
    assert_equal assignees.to_json, @response.body
  end

  def test_autocomplete_by_login
    user = User.find(3)
    assignees = [{ :label => user.name, :value => user.id }]
    get :autocomplete, :project_id => @project.id, :term => user.login
    assert_response :success
    assert_equal assignees.to_json, @response.body
  end

  def construct_assignees_list
    # me + sorted users + sorted groups
    users = @project.assignable_users.find_all { |u| !u.is_a?(Group) }.sort
    groups = @project.assignable_users.find_all { |u| u.is_a?(Group) }.sort
    [{ label: "<< #{l(:label_me)} >>", value: @user.id }] +
        users.map { |u| { :label => u.name, :value => u.id } } +
        groups.map { |u| { :label => "#{l(:label_group)}: #{u.name}", :value => u.id } }
  end

end
