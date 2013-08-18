# replace assignee select to hidden input

Deface::Override.new(
    :virtual_path => 'issues/_attributes',
    :name => 'issue_attributes_hidden_assignee',
    :replace => 'code:contains("f.select :assigned_to_id")',
    :text => '<label><%= l(:field_assigned_to) %></label>' +
        '<%= assignee_hidden_field(f, @issue) %>')
