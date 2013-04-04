Deface::Override.new(
    :virtual_path => 'issues/new',
    :name => 'simplify_issue_new',
    :insert_after => 'code:contains("preview_link preview_new_issue_path(:project_id => @project)")',
    :text => '<%= link_to_simplify_on %>')
