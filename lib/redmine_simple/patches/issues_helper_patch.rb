module RedmineSimple::Patches
  module IssuesHelperPatch
    extend ActiveSupport::Concern

    def link_to_simplify_on(active = true)
      link_class = 'simplify-on icon icon-arrow-in'
      link_class += ' active' if active
      link_to l(:text_simplify_on), '#', { :class => link_class }
    end

    def link_to_simplify_off(active = true)
      link_class = 'simplify-off icon icon-arrow-out'
      link_class += ' active' if active
      link_to l(:text_simplify_off), '#', { :class => link_class }
    end

  end
end

unless IssuesHelper.included_modules.include?(RedmineSimple::Patches::IssuesHelperPatch)
  IssuesHelper.send :include, RedmineSimple::Patches::IssuesHelperPatch
end
