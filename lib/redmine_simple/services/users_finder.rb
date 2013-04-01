module RedmineSimple::Services
  class UsersFinder
    class << self
      def find_users(q)
        User.like
      end
    end
  end
end
