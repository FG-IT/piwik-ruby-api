module Piwik
  class UserCountry < ApiModule
    available_methods %W{
      getCountry
      getContinent
      getRegion
      getCity
      getLocationFromIP
      getNumberOfDistinctCountries
    }

    scoped_methods do
      def countries params = {}
        getCountry(defaults.merge(params))
      end

      def continents params = {}
        getContinent(defaults.merge(params))
      end

      def regions params = {}
        getRegion(defaults.merge(params))
      end

      def cities params = {}
        getCity(defaults.merge(params))
      end
    end
  end
end
