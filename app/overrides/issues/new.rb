Deface::Override.new(
    :virtual_path => 'issues/new',
    :name => 'ads_simple_links_to_new_issue',
    :insert_after => 'code:contains("preview_link preview_new_issue_path(:project_id => @project)")',
    :text => '<%= link_to_simplify_on(!User.current.pref.simplify?) %><%= link_to_simplify_off(User.current.pref.simplify?) %>')
