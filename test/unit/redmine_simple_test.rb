require File.expand_path('../../test_helper', __FILE__)

class RedmineSimpleTest < ActiveSupport::TestCase
  fixtures :users

  def setup
    @user = User.find(3)
    User.current = @user
  end

  def test_simplify_on?
    @user.pref.stubs(:simplify?).returns(true)
    assert_equal true, RedmineSimple.on?
  end

  def test_simplify_off?
    @user.pref.stubs(:simplify?).returns(false)
    assert_equal false, RedmineSimple.on?
  end

  def test_disabling_simplify
    RedmineSimple.disable
    assert_equal false, @user.pref.simplify?
    assert_equal false, RedmineSimple.on?
  end

  def test_enabling_simplify
    RedmineSimple.enable
    assert_equal true, @user.pref.simplify?
    assert_equal true, RedmineSimple.on?
  end
end
