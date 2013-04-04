module RedmineSimple::Hooks
  class ViewHooks < Redmine::Hook::ViewListener
    render_on :view_issues_new_top,
              :partial => 'hooks/redmine_simple/issues/new'

    render_on :view_issues_form_details_bottom,
              :partial => 'hooks/redmine_simple/issues/assignee'
  end
end
