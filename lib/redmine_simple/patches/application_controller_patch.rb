require_dependency 'application_controller'

module RedmineSimple::Patches
  module ApplicationControllerPatch
    extend ActiveSupport::Concern

    included do
      before_filter :update_simplify_from_params
      before_filter :include_redmine_simple_helper
    end

    protected

    def update_simplify_from_params
      prm = params.delete('simplify')
      unless prm.nil?
        prm == 'on' ? RedmineSimple.enable : RedmineSimple.disable
      end
      true
    end

    # A way to make plugin helpers available in all views
    def include_redmine_simple_helper
      unless _helpers.included_modules.include? RedmineSimpleHelper
        self.class.helper RedmineSimpleHelper
      end
      true
    end

  end
end

unless ApplicationController.included_modules.include?(RedmineSimple::Patches::ApplicationControllerPatch)
  ApplicationController.send :include, RedmineSimple::Patches::ApplicationControllerPatch
end
