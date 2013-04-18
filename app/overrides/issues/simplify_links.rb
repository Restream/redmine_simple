# add simplify link to new issue form
Deface::Override.new(
    :virtual_path => 'issues/new',
    :name => 'issue_new_add_simplify_link',
    :insert_after => 'code:contains("preview_link preview_new_issue_path(:project_id => @project)")',
    :text => '<%= link_to_new_issue_simplify_on(@project) %>')

# add simplify link to edit issue form
Deface::Override.new(
    :virtual_path => 'issues/_edit',
    :name => 'simplify_issue_edit',
    :insert_after => 'code:contains("preview_link preview_edit_issue_path(:project_id => @project, :id => @issue), \'issue-form\'")',
    :text => '<%= link_to_edit_issue_simplify_on(@issue) %>')
