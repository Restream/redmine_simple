# replace entire view with 'simple/issues/edit' if RedmineSimple.on?

Deface::Override.new(
    :virtual_path => 'issues/edit',
    :name => 'issue_edit_cond_top',
    :insert_before => 'h2',
    :text => '<% if RedmineSimple.on? %><%= render :template => "simple/issues/edit" %><% else %>')

Deface::Override.new(
    :virtual_path => 'issues/edit',
    :name => 'issue_edit_cond_bottom',
    :surround => "erb[silent]:contains('content_for :header_tags')",
    :closing_selector => "erb[silent]:contains('end')",
    :text => '<%= render_original %><% end %>')
