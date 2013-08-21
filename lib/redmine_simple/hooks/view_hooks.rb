module RedmineSimple::Hooks
  class ViewHooks < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head,
              :partial => 'hooks/redmine_simple/includes'
  end
end
