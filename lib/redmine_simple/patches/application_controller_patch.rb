require_dependency 'application_controller'

module RedmineSimple::Patches
  module ApplicationControllerPatch
    extend ActiveSupport::Concern

    included do
      before_filter :update_simplify_from_params
    end

    protected

    def update_simplify_from_params
      prm = params.delete('simplify')
      unless prm.nil?
        prm == 'on' ? RedmineSimple.enable : RedmineSimple.disable
      end
      true
    end

  end
end

unless ApplicationController.included_modules.include?(RedmineSimple::Patches::ApplicationControllerPatch)
  ApplicationController.send :include, RedmineSimple::Patches::ApplicationControllerPatch
end
