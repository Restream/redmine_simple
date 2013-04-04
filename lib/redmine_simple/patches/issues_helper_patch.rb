require_dependency 'issues_helper'

module RedmineSimple::Patches
  module IssuesHelperPatch
    extend ActiveSupport::Concern

    def link_to_simplify_on
      (link_to_simplify_link('on') + link_to_simplify_js('on')).html_safe
    end

    def link_to_simplify_off
      (link_to_simplify_link('off') + link_to_simplify_js('off')).html_safe
    end

    def link_to_simplify_link(simplify)
      link_class = "simplify-#{simplify}"
      link_to(l("text_simplify_#{simplify}"), '#', { :class => link_class })
    end

    def link_to_simplify_js(simplify)
      javascript_tag("$('a.simplify-#{simplify}').click(function() { updateIssueFrom('#{escape_javascript(
          project_issue_form_path(@project, :id => @issue, :simplify => simplify, :format => 'js')
          )}'); return false;});")
    end
  end
end

unless IssuesHelper.included_modules.include?(RedmineSimple::Patches::IssuesHelperPatch)
  IssuesHelper.send :include, RedmineSimple::Patches::IssuesHelperPatch
end
