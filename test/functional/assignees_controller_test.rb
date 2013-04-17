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
    assignees = construct_assignees_list
    get :autocomplete, :project_id => @project.id
    assert_response :success
    assert_equal assignees.to_json, @response.body
  end

  def test_autocomplete_by_login
    user = User.find(3)
    assignees = { :more => false, :results => [{ :text => user.name, :id => user.id }]}
    get :autocomplete, :project_id => @project.id, :term => user.login
    assert_response :success
    assert_equal assignees.to_json, @response.body
  end

  def construct_assignees_list
    # me + sorted users + sorted groups
    groups, users = @project.assignable_users.sort.partition { |u| u.is_a?(Group) }
    {
        :more => false,
        :results =>
            [{ text: "<< #{l(:label_me)} >>", id: @user.id }] +
            users.map { |u| { :text => u.name, :id => u.id } } +
            (groups.empty? ? [] :
            [{
                 text: l(:label_group),
                 :children =>
                      groups.map do |u|
                        { :text => "#{l(:label_group)}: #{u.name}", :id => u.id }
                      end
            }])
    }
  end

end
