require 'redmine'

Rails.application.paths["app/overrides"] ||= []
Rails.application.paths["app/overrides"] << File.expand_path("../app/overrides", __FILE__)

ActionDispatch::Callbacks.to_prepare do
  require 'redmine_simple'
end

Redmine::Plugin.register :redmine_simple do
  name        'Redmine Simple plugin'
  description 'This plugin provides a simplified Redmine interface.'
  author      'Undev'
  version     '1.1.5'
  url         'https://github.com/Undev/redmine_simple'

  requires_redmine :version_or_higher => '2.1'
  requires_redmine_plugin :redmine__select2, :version_or_higher => '1.0.1'
end
