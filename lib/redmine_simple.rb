require 'singleton'
class RedmineSimple
  class << self
    def on?(user = User.current)
      user.pref.simplify?
    end

    def enable(user = User.current)
      user.pref.simplify = true
      user.pref.save
    end

    def disable(user = User.current)
      user.pref.simplify = false
      user.pref.save
    end
  end
end

#extends
require 'redmine_simple/extends/select2_ids'

#patches
require 'redmine_simple/patches/user_preference_patch'
require 'redmine_simple/patches/application_controller_patch'
require 'redmine_simple/patches/issue_patch'
require 'redmine_simple/patches/issues_controller_patch'

#hooks
require 'redmine_simple/hooks/view_hooks'

if Rails.env == 'test'
  # This plugin change redmine functionality so tests should be changed too
  require 'redmine_simple/patches/issues_controller_test_patch'
end
