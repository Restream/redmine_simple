require 'redmine'

Rails.application.paths["app/overrides"] ||= []
Rails.application.paths["app/overrides"] << File.expand_path("../app/overrides", __FILE__)

ActionDispatch::Callbacks.to_prepare do
  require 'redmine_simple'
end

Redmine::Plugin.register :redmine_simple do
  name        'RedmineSimple plugin'
  description 'Simplify redmine interface'
  author      'Danil Tashkinov'
  version     '0.0.9'
  url         'https://github.com/Undev/redmine_simple'

  requires_redmine :version_or_higher => '2.1'

  # permission for autocomplete must be the same as :add_issues
  Redmine::AccessControl.permission(:add_issues).actions << 'assignees/autocomplete'
  Redmine::AccessControl.permission(:add_issues).actions << 'issues/new_content'
end
