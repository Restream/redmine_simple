require_dependency 'issues_helper'

module RedmineSimple::Patches
  module IssuesHelperPatch
    extend ActiveSupport::Concern

    def link_to_new_issue_simplify_on(project)
      link_to_new_issue_simplify_link(project, 'on')
    end

    def link_to_new_issue_simplify_off(project)
      link_to_new_issue_simplify_link(project, 'off')
    end

    def link_to_new_issue_simplify_link(project, simplify)
      raise ArgumentError('allowed only on|off values') unless simplify =~ /^on|off$/
      link_class = "simplify-#{simplify}"
      link_to l("text_simplify_#{simplify}"),
              project_issue_form_path(project, :simplify => simplify),
              { :class => link_class }
    end

    def link_to_edit_issue_simplify_on(issue)
      link_to_edit_issue_simplify_link(issue, 'on')
    end

    def link_to_edit_issue_simplify_off(issue)
      link_to_edit_issue_simplify_link(issue, 'off')
    end

    def link_to_edit_issue_simplify_link(issue, simplify)
      raise ArgumentError('allowed only on|off values') unless simplify =~ /^on|off$/
      link_class = "simplify-#{simplify}"
      link_to l("text_simplify_#{simplify}"),
              edit_issue_path(issue, :simplify => simplify),
              { :class => link_class }
    end
  end
end

unless IssuesHelper.included_modules.include?(RedmineSimple::Patches::IssuesHelperPatch)
  IssuesHelper.send :include, RedmineSimple::Patches::IssuesHelperPatch
end
