module Piwik
  class DevicesDetection < ApiModule
    available_methods %W{
      getType
      getBrand
      getModel
      getOsFamilies
      getOsVersions
      getBrowserVersions
      getBrowserFamilies
    }

    scoped_methods do
      def types params = {}
        getType(defaults.merge(params))
      end

      def brand params = {}
        getBrand(defaults.merge(params))
      end

      def model params = {}
        getModel(defaults.merge(params))
      end

      def os_families params = {}
        getOsFamilies(defaults.merge(params))
      end

      def os_versions params = {}
        getOsVersions(defaults.merge(params))
      end

      def browser_verions params = {}
        getBrowserVersions(defaults.merge(params))
      end

      def browser_families params = {}
        getBrowserFamilies(defaults.merge(params))
      end
    end
  end
end
