require_dependency 'issues_controller'

module RedmineSimple::Patches
  module IssuesControllerPatch
    extend ActiveSupport::Concern

    included do
      alias_method_chain :new, :simple
      alias_method_chain :edit, :simple
    end

    def new_with_simple
      render :action => 'new_ext'
    end

    def edit_with_simple
      return unless update_issue_from_params

      respond_to do |format|
        format.html { render :action => 'edit_ext' }
        format.xml  { }
      end
    end

  end
end

unless IssuesController.included_modules.include?(RedmineSimple::Patches::IssuesControllerPatch)
  IssuesController.send :include, RedmineSimple::Patches::IssuesControllerPatch
end
