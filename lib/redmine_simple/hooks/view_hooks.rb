module RedmineSimple::Hooks
  class ViewHooks < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head,
              :partial => 'hooks/redmine_simple/includes'
    render_on :view_issues_form_details_bottom,
              :partial => 'hooks/redmine_simple/form_includes'
  end
end
