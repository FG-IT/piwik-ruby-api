module Piwik
  class Events < ApiModule
    available_methods %W{
      getCategory
      getAction
      getName
      getActionFromCategoryId
      getNameFromCategoryId
      getCategoryFromActionId
      getNameFromActionId
      getActionFromNameId
      getCategoryFromNameId
    }

    scoped_methods do
      def category params = {}
        getCategory(defaults.merge(params))
      end

      def action params = {}
        getAction(defaults.merge(params))
      end

      def name params = {}
        getName(defaults.merge(params))
      end

      def action_from_category params = {}
        getActionFromCategoryId(defaults.merge(params))
      end

      def name_from_category params = {}
        getNameFromCategoryId(defaults.merge(params))
      end

      def category_from_action params = {}
        getCategoryFromActionId(defaults.merge(params))
      end

      def name_from_action params = {}
        getNameFromActionId(defaults.merge(params))
      end

      def action_from_name params = {}
        getActionFromNameId(defaults.merge(params))
      end

      def category_from_name params = {}
        getCategoryFromNameId(defaults.merge(params))
      end
    end
  end
end
