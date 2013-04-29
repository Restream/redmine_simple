module RedmineSimple::Patches
  module WatchersControllerPatch
    extend ActiveSupport::Concern

    def users
      @users = find_users_like(params[:term])
      render :layout => nil
    end

    protected

    def find_users_like(q)
      q = q.to_s.strip.downcase

      # Take only one space between first name and lastname
      q.sub! /\s{2,}/, ' '

      User.active.like(q).limit(100).sort
    end

  end
end

unless WatchersController.included_modules.include?(RedmineSimple::Patches::WatchersControllerPatch)
  WatchersController.send :include, RedmineSimple::Patches::WatchersControllerPatch
end
