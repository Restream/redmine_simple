Deface::Override.new(
    :virtual_path => 'issues/new',
    :name => 'simplify_issue_new',
    :surround => 'h2',
    :closing_selector => "code[erb-silent]:contains('end'):last",
    :text => <<ENDOF
<% if RedmineSimple.on? %>
  <%= render :partial => 'simple/issues/new' %>
<% else %>
  <%= render_original %>
<% end %>
ENDOF
)

# <%= link_to_simplify_on(!User.current.pref.simplify?) %><%= link_to_simplify_off(User.current.pref.simplify?) %>
