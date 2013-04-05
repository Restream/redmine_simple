require_dependency 'issues_controller'

module RedmineSimple::Patches
  module IssuesControllerPatch
    extend ActiveSupport::Concern

    included do
      alias_method_chain :new, :simple
    end

    def new_with_simple
      render :action => 'new_ext'
    end

  end
end

unless IssuesController.included_modules.include?(RedmineSimple::Patches::IssuesControllerPatch)
  IssuesController.send :include, RedmineSimple::Patches::IssuesControllerPatch
end
