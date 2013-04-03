require File.expand_path('../../test_helper', __FILE__)

class RedmineSimpleSwitcherTest < ActionController::IntegrationTest
  fixtures :projects, :trackers, :issue_statuses, :issues,
           :enumerations, :users, :issue_categories,
           :projects_trackers,
           :roles,
           :member_roles,
           :members,
           :enabled_modules,
           :workflows,
           :users

  def setup
    @user = User.find(2)
    @project = Project.find(1)
    log_user('jsmith', 'jsmith')
  end

  def test_simplify_on?
    RedmineSimple.depend_on_user
    user_simplify_on
    get "/projects/#{@project.to_param}/issues/new"
    assert_response :success
    assert_true RedmineSimple.on?
  end

  def test_simplify_off?
    RedmineSimple.depend_on_user
    user_simplify_off
    get "/projects/#{@project.to_param}/issues/new"
    assert_response :success
    assert_false RedmineSimple.on?
  end

  def test_simplify_disabled
    RedmineSimple.depend_on_user
    user_simplify_on
    get "/projects/#{@project.to_param}/issues/new?simplify=off"
    assert_response :success
    assert_false RedmineSimple.on?
  end

  def test_simplify_enabled
    RedmineSimple.depend_on_user
    user_simplify_off
    get "/projects/#{@project.to_param}/issues/new?simplify=on"
    assert_response :success
    assert_true RedmineSimple.on?
  end

  private

  def user_simplify_on
    @user.pref.simplify = true
    @user.pref.save!
  end

  def user_simplify_off
    @user.pref.simplify = false
    @user.pref.save!
  end
end
