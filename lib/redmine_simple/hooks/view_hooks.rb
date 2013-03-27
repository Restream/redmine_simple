module RedmineSimple::Hooks
  class ViewHooks < Redmine::Hook::ViewListener
    render_on :view_issues_new_top,
              :partial => 'hooks/redmine_simple/issues/new'
  end
end
