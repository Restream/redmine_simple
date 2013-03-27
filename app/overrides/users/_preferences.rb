Deface::Override.new(
    :virtual_path => 'users/_preferences',
    :name => 'simplify_preferences',
    :insert_before => 'code:contains("end"):last',
    :text => '<p><%= pref_fields.check_box :simplify %></p>')
