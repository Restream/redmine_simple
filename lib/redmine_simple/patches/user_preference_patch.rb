require_dependency 'user_preference'

module RedmineSimple::Patches
  module UserPreferencePatch
    extend ActiveSupport::Concern

    def simplify
      self[:simplify]
    end

    def simplify=(val)
      val = 1 if val.is_a? TrueClass
      val = 0 if val.is_a? FalseClass
      self[:simplify] = val
    end

    def simplify?
      simplify.to_i == 1
    end

  end
end

unless UserPreference.included_modules.include?(RedmineSimple::Patches::UserPreferencePatch)
  UserPreference.send :include, RedmineSimple::Patches::UserPreferencePatch
end
