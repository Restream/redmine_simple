module RedmineSimple::Patches
  module ApplicationControllerPatch
    extend ActiveSupport::Concern

    included do
      before_filter :detect_simplify
    end

    protected

    def detect_simplify
      prm = params.delete('simplify')
      if prm.nil?
        RedmineSimple.depend_on_user
      else
        prm == 'on' ? RedmineSimple.enable : RedmineSimple.disable
      end
      true
    end

  end
end

unless ApplicationController.included_modules.include?(RedmineSimple::Patches::ApplicationControllerPatch)
  ApplicationController.send :include, RedmineSimple::Patches::ApplicationControllerPatch
end
