module Piwik
  class UserLanguage < ApiModule
    available_methods %W{
      getLanguage
      getLanguageCode
    }

    scoped_methods do
      def countries params = {}
        getCountry(defaults.merge(params))
      end

      def continents params = {}
        getContinent(defaults.merge(params))
      end

      def language params = {}
        getLanguage(defaults.merge(params))
      end

      def languageCode params = {}
        getLanguageCode(defaults.merge(params))
      end
    end
  end
end
