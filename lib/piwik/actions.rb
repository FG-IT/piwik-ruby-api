module Piwik
  class Actions < ApiModule
    available_methods %W{
      get
      getPageUrls
      getPageUrlsFollowingSiteSearch
      getPageTitlesFollowingSiteSearch
      getEntryPageUrls
      getExitPageUrls
      getPageUrl
      getPageTitles
      getEntryPageTitles
      getExitPageTitles
      getPageTitle
      getDownloads
      getDownload
      getOutlinks
      getOutlink
      getSiteSearchKeywords
      addPagesPerSearchColumn
      getSiteSearchNoResultKeywords
      getSiteSearchCategories
    }

    scoped_methods do
      def summary params = {}
        get(defaults.merge(params))
      end

      def urls params = {}
        getPageUrls(defaults.merge(params))
      end

      def url(page_url, params = {})
        getPageUrl(defaults.merge(params).merge(:pageUrl => page_url))
      end

      def entry_urls params = {}
        getEntryPageUrls(defaults.merge(params))
      end

      def exit_urls params = {}
        getExitPageUrls(defaults.merge(params))
      end

      def downloads params = {}
        getDownloads(defaults.merge(params))
      end

      def download(download_url, params = {})
        getDownload(defaults.merge(params).merge(:downloadUrl => download_url))
      end

      def outlinks params = {}
        getOutlinks(defaults.merge(params))
      end

      def outlink(outlink_url, params = {})
        getOutlink(defaults.merge(params).merge(:outlinkUrl => outlink_url))
      end
    end
  end
end
