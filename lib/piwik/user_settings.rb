module Piwik
  class UserSettings < ApiModule
    available_methods %W{
      getResolution
      getConfiguration
      getOs
      getOsFamily
      getMobileVsDesktop
      getBrowserVersion
      getBrowser
      getBrowserType
      getWideScreen
      getPlugin
      getLanguage
      getLanguageCode
    }

    scoped_methods do
      def resolution params = {}
        getResolution(defaults.merge(params))
      end

      def language params = {}
        getLanguage(defaults.merge(params))
      end

      def languageCode params = {}
        getLanguageCode(defaults.merge(params))
      end

      def get_os params = {}
        getOs(defaults.merge(params))
      end

      def get_os_family params = {}
        getOsFamily(defaults.merge(params))
      end
    end
  end
end
