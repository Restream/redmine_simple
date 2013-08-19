require_dependency 'issues_controller'

module RedmineSimple::Patches
  module IssuesControllerPatch
    extend ActiveSupport::Concern

    included do
      # get notes from params when simple mode is on and xhr request
      before_filter :get_notes_from_params,
                    :only => [:new],
                    :if => -> { RedmineSimple.on? && request.xhr? }
    end

    protected

    def get_notes_from_params
      @notes = params[:issue] && params[:issue][:notes]
    end

  end
end

unless IssuesController.included_modules.include?(RedmineSimple::Patches::IssuesControllerPatch)
  IssuesController.send :include, RedmineSimple::Patches::IssuesControllerPatch
end
