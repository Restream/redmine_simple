require File.expand_path('../../test_helper', __FILE__)

class UserPreferencesTest < ActiveSupport::TestCase
  fixtures :users

  def setup
    @user = find_user
  end

  def test_simplify_set
    @user.pref.simplify = true
    @user.pref.save!
    user = find_user
    assert_equal true, user.pref.simplify?
  end

  def test_simplify_clear
    @user.pref.simplify = false
    @user.pref.save!
    user = find_user
    assert_equal false, user.pref.simplify?
  end

  def test_simplify_by_default_false
    assert_equal false, @user.pref.simplify?
  end

  def find_user
    User.find(2)
  end

end
