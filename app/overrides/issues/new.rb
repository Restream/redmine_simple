# replace entire view with 'simple/issues/new' if RedmineSimple.on?

Deface::Override.new(
    :virtual_path => 'issues/new',
    :name => 'issue_new_cond_top',
    :insert_before => 'h2',
    :text => '<% if RedmineSimple.on? %><%= render :template => "simple/issues/new" %><% else %>')

Deface::Override.new(
    :virtual_path => 'issues/new',
    :name => 'issue_new_cond_bottom',
    :surround => "code[erb-silent]:contains('content_for :header_tags')",
    :closing_selector => "code[erb-silent]:contains('end')",
    :text => '<%= render_original %><% end %><%= render :partial => "simple/issues/includes" %>')
