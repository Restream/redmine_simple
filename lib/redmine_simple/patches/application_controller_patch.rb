require_dependency 'application_controller'

module RedmineSimple::Patches
  module ApplicationControllerPatch
    extend ActiveSupport::Concern

    included do
      before_filter :detect_simplify
    end

    protected

    def detect_simplify
      update_session_simplify_from_params
      val = session[:simplify]
      if val.nil?
        RedmineSimple.depend_on_user
      else
        val == 'on' ? RedmineSimple.enable : RedmineSimple.disable
      end
      true
    end

    def update_session_simplify_from_params
      prm = params.delete('simplify')
      session[:simplify] = prm unless prm.nil?
    end

  end
end

unless ApplicationController.included_modules.include?(RedmineSimple::Patches::ApplicationControllerPatch)
  ApplicationController.send :include, RedmineSimple::Patches::ApplicationControllerPatch
end
