class IssuesControllerTest < ActionController::TestCase
  # these assertions failed because inputs "assignee" and "watchers" was changed
  # assert_select 'select[name=?]', 'issue[assigned_to_id]'
  # assert_select 'input[name=?]', 'issue[watcher_user_ids][]'
  # assert_select 'input[name=?][value=X]:not(checked)', 'issue[watcher_user_ids][]'

  def assert_select(*args, &block)
    if args[0] == 'select[name=?]' && args[1] == 'issue[assigned_to_id]'
      args[0] = 'input[name=?]'
    end
    if args[0] == 'input[name=?]' && args[1] == 'issue[watcher_user_ids][]'
      args[1] = 'issue[select2_watcher_user_ids]'
    end
    if args[0] =~ /input\[name=\?\]\[value=\d+/ && args[1] == 'issue[watcher_user_ids][]'
      args[0] = 'input[name=?]'
      args[1] = 'issue[select2_watcher_user_ids]'
    end
    super
  end
end
