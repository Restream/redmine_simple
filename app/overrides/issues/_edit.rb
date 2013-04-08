Deface::Override.new(
    :virtual_path => 'issues/_edit',
    :name => 'simplify_issue_edit',
    :insert_after => 'code:contains("preview_link preview_edit_issue_path(:project_id => @project, :id => @issue), \'issue-form\'")',
    :text => '<%= link_to_edit_issue_simplify_on(@issue) %>')
