module RedmineSimple::Patches
  module WatchersControllerPatch
    extend ActiveSupport::Concern

    included do
      before_filter :find_project_by_project_id, :only => :autocomplete_for_project
    end

    def autocomplete_for_project
      @members, @non_members = find_users_like(params[:term])
      render :layout => nil
    end

    protected

    def find_users_like(q)
      q = q.to_s.strip.downcase

      # Take only one space between first name and lastname
      q.sub! /\s{2,}/, ' '

      members = @project.users.pluck(:user_id)
      User.active.like(q).limit(100).sort.partition { |u| members.include?(u.id) }
    end

  end
end

unless WatchersController.included_modules.include?(RedmineSimple::Patches::WatchersControllerPatch)
  WatchersController.send :include, RedmineSimple::Patches::WatchersControllerPatch
end
