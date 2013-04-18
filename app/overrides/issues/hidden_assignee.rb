# replace assignee select to hidden input

Deface::Override.new(
    :virtual_path => 'issues/_attributes',
    :name => 'issue_attributes_hidden_assignee',
    :replace => 'code:contains("f.select :assigned_to_id")',
    :text => '<label><%= l(:field_assigned_to) %></label><%= f.hidden_field :assigned_to_id, :data => { :text => @issue.assigned_to.try(:name).to_s } %>')
