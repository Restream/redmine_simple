require File.expand_path('../../test_helper', __FILE__)

class RedmineSimpleTest < ActiveSupport::TestCase
  fixtures :users

  def setup
    @user = User.find(3)
    User.current = @user
  end

  def test_simplify_on?
    RedmineSimple.depend_on_user
    @user.pref.stubs(:simplify?).returns(true)
    assert_true RedmineSimple.on?
  end

  def test_simplify_off?
    RedmineSimple.depend_on_user
    @user.pref.stubs(:simplify?).returns(false)
    assert_false RedmineSimple.on?
  end

  def test_disabling_simplify
    RedmineSimple.disable
    @user.pref.stubs(:simplify?).returns(true)
    assert_false RedmineSimple.on?
  end

  def test_enabling_simplify
    RedmineSimple.enable
    @user.pref.stubs(:simplify?).returns(false)
    assert_true RedmineSimple.on?
  end
end
