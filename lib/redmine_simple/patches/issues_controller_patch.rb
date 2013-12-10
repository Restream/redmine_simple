require_dependency 'issues_controller'

module RedmineSimple::Patches
  module IssuesControllerPatch
    extend ActiveSupport::Concern

    included do
      # get notes from params when simple mode is on and xhr request
      before_filter :get_notes_from_params,
                    :only => [:new, :update_form],
                    :if => -> { RedmineSimple.on? && request.xhr? }
      before_filter :enable_deface_for_html_only, :only => [:show]

      alias_method_chain :new, :simple
    end

    def new_with_simple
      respond_to do |format|
        format.html { render :template => template_for_new_form, :layout => !request.xhr? }
      end
    end

    protected

    def get_notes_from_params
      @notes = params[:issue] && params[:issue][:notes]
    end

    def enable_deface_for_html_only
      Rails.application.config.deface.enabled = request.format.html?
    end

    def template_for_new_form
      RedmineSimple.on? ? 'simple/issues/new' : 'issues/new'
    end

  end
end

unless IssuesController.included_modules.include?(RedmineSimple::Patches::IssuesControllerPatch)
  IssuesController.send :include, RedmineSimple::Patches::IssuesControllerPatch
end
