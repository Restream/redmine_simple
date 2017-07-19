# replace issue edit partial if RedmineSimple.on?

Deface::Override.new(
    :virtual_path => 'issues/show',
    :name => 'simplify_issue_edit_partial',
    :replace => 'erb[loud]:contains("render :partial => \'edit\'")',
    :text => <<-INCLUDES
<% if RedmineSimple.on? %>
  <%= render :partial => 'simple/issues/edit' %>
<% else %>
  <%= render :partial => 'edit' %>
<% end %>
INCLUDES
)
