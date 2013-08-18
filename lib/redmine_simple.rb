require 'singleton'
class RedmineSimple
  include Singleton

  %w{on? depend_on_user enable disable}.each do |meth|
    define_singleton_method(meth.to_sym) { |*args| instance.send meth.to_sym, *args  }
  end

  def on?(user = User.current)
    @direct_switch.nil? ? user.pref.simplify? : @direct_switch
  end

  def depend_on_user
    @direct_switch = nil
  end

  def enable
    @direct_switch = true
  end

  def disable
    @direct_switch = false
  end
end

#extends
require 'redmine_simple/extends/select2_ids'

#patches
require 'redmine_simple/patches/issues_helper_patch'
require 'redmine_simple/patches/user_preference_patch'
require 'redmine_simple/patches/application_controller_patch'
require 'redmine_simple/patches/issue_patch'
