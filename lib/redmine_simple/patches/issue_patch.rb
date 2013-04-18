module RedmineSimple::Patches
  module IssuePatch
    extend ActiveSupport::Concern

    included do
      select2_ids :watcher_user

      safe_attributes 'select2_watcher_user_ids',
                      :if => lambda {|issue, user| issue.new_record? && user.allowed_to?(:add_issue_watchers, issue.project)}
    end

  end
end

unless Issue.included_modules.include? RedmineSimple::Patches::IssuePatch
  Issue.send :include, RedmineSimple::Patches::IssuePatch
end
