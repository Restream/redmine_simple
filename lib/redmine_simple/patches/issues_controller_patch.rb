require_dependency 'issues_controller'

module RedmineSimple::Patches
  module IssuesControllerPatch
    extend ActiveSupport::Concern

    included do
      alias_method_chain :new, :simple
    end

    def new_with_simple
      respond_to do |format|
        format.html { render :action => 'new_ext', :layout => !request.xhr? }
        format.js { render :partial => 'update_new_content' }
      end
    end

  end
end

unless IssuesController.included_modules.include?(RedmineSimple::Patches::IssuesControllerPatch)
  IssuesController.send :include, RedmineSimple::Patches::IssuesControllerPatch
end
