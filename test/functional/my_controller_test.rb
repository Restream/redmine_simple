require File.expand_path('../../test_helper', __FILE__)
require 'my_controller'

# Re-raise errors caught by the controller.
class MyController; def rescue_action(e) raise e end; end

class MyControllerTest < ActionController::TestCase
  fixtures :users, :user_preferences, :roles, :projects, :members, :member_roles,
           :issues, :issue_statuses, :trackers, :enumerations, :custom_fields, :auth_sources

  def setup
    @controller = MyController.new
    @request    = ActionController::TestRequest.new
    @request.session[:user_id] = 2
    @response   = ActionController::TestResponse.new
  end

  def test_update_account
    user = User.find(2)
    user.pref.simplify = false
    user.pref.save!
    post :account,
         :pref => {
             :simplify => 1
         }
    assert_redirected_to '/my/account'
    user = User.find(2)
    assert_true user.pref.simplify?
  end

  def test_show_simplify_checkbox
    get :account
    assert_tag :input, :attributes => { :name => 'pref[simplify]' }
  end
end
