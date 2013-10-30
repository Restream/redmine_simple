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
    simplify_on!(@user)
    get "/projects/#{@project.to_param}/issues/new"
    assert_response :success
    assert_equal true, RedmineSimple.on?
    assert_tag :div, :attributes => { :class => 'simple-hidden' }
  end

  def test_simplify_off?
    RedmineSimple.depend_on_user
    simplify_off!(@user)
    get "/projects/#{@project.to_param}/issues/new"
    assert_response :success
    assert_equal false, RedmineSimple.on?
    assert_no_tag :div, :attributes => { :class => 'simple-hidden' }
  end

  def test_simplify_disabled
    RedmineSimple.depend_on_user
    simplify_on!(@user)
    get "/projects/#{@project.to_param}/issues/new?simplify=off"
    assert_response :success
    assert_equal false, RedmineSimple.on?
    assert_no_tag :div, :attributes => { :class => 'simple-hidden' }
  end

  def test_simplify_enabled
    RedmineSimple.depend_on_user
    simplify_off!(@user)
    get "/projects/#{@project.to_param}/issues/new?simplify=on"
    assert_response :success
    assert_equal true, RedmineSimple.on?
    assert_tag :div, :attributes => { :class => 'simple-hidden' }
  end

end
