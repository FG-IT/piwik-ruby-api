module Piwik
  class SitesManager < ApiModule
    available_methods %W{
      getJavascriptTag
      getSitesFromGroup
      getSitesGroups
      getSiteFromId
      getSiteUrlsFromId
      getAllSites
      getAllSitesId
      getSitesIdWithVisits
      getSitesWithAdminAccess
      getSitesWithViewAccess
      getSitesWithAtLeastViewAccess
      getSitesIdWithAdminAccess
      getSitesIdWithViewAccess
      getSitesIdWithAtLeastViewAccess
      getSitesIdFromSiteUrl
      addSite
      deleteSite
      addSiteAliasUrls
      getIpsForRange
      setGlobalExcludedIps
      setGlobalSearchParameters
      getSearchKeywordParametersGlobal
      getSearchCategoryParametersGlobal
      getExcludedQueryParametersGlobal
      getExcludedUserAgentsGlobal
      setGlobalExcludedUserAgents
      isSiteSpecificUserAgentExcludeEnabled
      setSiteSpecificUserAgentExcludeEnabled
      setGlobalExcludedQueryParameters
      getExcludedIpsGlobal
      getDefaultCurrency
      setDefaultCurrency
      getDefaultTimezone
      setDefaultTimezone
      updateSite
      getCurrencyList
      getCurrencySymbols
      getTimezonesList
      getUniqueSiteTimezones
      getPatternMatchSites
    }

    def self.get params
      resp = self.get_site_from_id(params)
      # Hack. The Piwik API get really weird sometimes
      raise Piwik::UnknownSite if resp.value == '0'
      Piwik::Site.new resp
    end

    # monkeypatching, as the Piwik API is inconsistent.
    # not all add methods return the same response type. Boo.
    def self.add params
      obj = Piwik::Site.new(params)
      resp = self.api_call('addSite',params)
      obj.attributes.idSite = resp
      obj
    end

    def self.save params
      self.api_call('updateSite',params)
    end

    def self.delete params
      self.api_call('deleteSite',params)
    end
  end
end
