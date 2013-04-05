require_dependency 'issues_helper'

module RedmineSimple::Patches
  module IssuesHelperPatch
    extend ActiveSupport::Concern

    def link_to_simplify_on
      link_to_simplify_link('on')
    end

    def link_to_simplify_off
      link_to_simplify_link('off')
    end

    def link_to_simplify_link(simplify)
      raise ArgumentError('allowed only on|off values') unless simplify =~ /^on|off$/
      link_class = "simplify-#{simplify}"
      link_to l("text_simplify_#{simplify}"),
              project_issue_form_path(
                  @project,
                  :id => @issue,
                  :simplify => simplify),
              { :class => link_class }
    end
  end
end

unless IssuesHelper.included_modules.include?(RedmineSimple::Patches::IssuesHelperPatch)
  IssuesHelper.send :include, RedmineSimple::Patches::IssuesHelperPatch
end
