Deface::Override.new(
    :virtual_path => 'issues/show',
    :name => 'simplify_issue_edit_partial',
    :replace => 'code:contains("render :partial => \'edit\'")',
    :text => "<%= render :partial => (RedmineSimple.on? ? 'simple/issues/edit' : 'edit') %>")
