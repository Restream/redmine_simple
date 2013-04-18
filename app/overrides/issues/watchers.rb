Deface::Override.new(
    :virtual_path => 'issues/new',
    :name => 'issues_new_watchers',
    :replace => 'p#watchers_form',
    :partial => 'simple/issues/watchers_form')
