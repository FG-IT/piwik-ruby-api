module Piwik
  class UsersFlow < ApiModule
    available_methods %W{
      getUsersFlowPretty
      getUsersFlow
      getInteractionActions
      getAvailableDataSources
    }

    scoped_methods do
      def users_flow params = {}
        getUsersFlow(defaults.merge(params))
      end

      def users_flow_pretty params = {}
        getUsersFlowPretty(defaults.merge(params))
      end
    end
  end
end
