require File.expand_path(File.dirname(__FILE__) + '../../../../test/test_helper')

class ActiveSupport::TestCase
  def simplify_on!(user)
    user.pref.simplify = true
    user.pref.save!
  end

  def simplify_off!(user)
    user.pref.simplify = false
    user.pref.save!
  end
end
