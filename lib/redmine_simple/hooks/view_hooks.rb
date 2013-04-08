module RedmineSimple::Hooks
  class ViewHooks < Redmine::Hook::ViewListener
    render_on :view_issues_edit_notes_bottom,
              :partial => 'hooks/redmine_simple/issues/includes'
  end
end
