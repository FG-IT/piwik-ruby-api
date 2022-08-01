module Piwik
  # <tt>Piwik::Site</tt> is a wrapper class used to expose a more ruby-friendly (and sane) interface to the Piwik API.
  # The Piwik API is under development, and there are quite a few incosistencies that are ironed out
  # when it is used through the <tt>Piwik::Site</tt> metaclass.
  #
  # Example usage using the bundled terminal script. Uses the official Piwik demo server as a sandbox
  #
  #   $ ./script/terminal -u http://demo.piwik.org -t anonymous
  #   > site = Piwik::Site.load(7)
  #   => #<Piwik::Site[snip]>
  #   > summary = site.visits.summary
  #   => #<Piwik::VisitsSummary[snip]>
  #   > summary.bounce_rate
  #   => "68%"
  #   > site.visits.count
  #   => 467
  #   > site.annotations.all
  #   => #<Piwik::Annotations::All[snip]>
  #   > site.annotations.add(:date => 'today', :note => 'twitter account online', :starred => '1')
  #   => Piwik::ApiError: The current user is not allowed to add notes for site #7
  #   > site.referers.website_count
  #   => 12
  #
  # This class creates site-aware proxies (called <tt>api_scopes</tt>) to the various client classes.
  # This lets you call api methods for a selected site without having to resubmit the site id all the time.
  # Furthermore, API methods are redefined as proxy_methods,
  # allowing for ruby-friendlier names, default parameters and other nice things.
  class Site < Base
    api_scope :referrers
    api_scope :visits, :class_name => 'VisitsSummary'
    api_scope :actions
    api_scope :transitions
    api_scope :annotations
    api_scope :scheduled_reports
    api_scope :goals
    api_scope :devices, :class_name => 'DevicesDetection'
    api_scope :user, :class_name => 'UserSettings'
    api_scope :countries, :class_name => 'UserCountry'
    api_scope :resolution
    api_scope :language, :class_name => 'UserLanguage'
    api_scope :users_flow
    api_scope :events

    # Returns search engine information for site home
    def seo_info
      Piwik::SEO.getRank(:url => self.main_url)
    end

    # Gives read access (<tt>'view'</tt>) to the supplied user login for the current site.
    def give_view_access_to(login)
      give_access_to(:view, login)
    end

    # Gives read and write access (<tt>'admin'</tt>) for the supplied user login for the current site.
    def give_admin_access_to(login)
      give_access_to(:admin, login)
    end

    # Removes all access (gives a <tt>'noaccess'</tt>) for the supplied user login for the current site.
    def give_no_access_to(login)
      give_access_to(:noaccess, login)
    end
    alias_method :remove_access_for, :give_no_access_to

    class << self
      def collection
        Piwik::SitesManager
      end

      def id_attr
        :idSite
      end
    end

    private
      # Gives the supplied access for the supplied user, for the current site.
      #
      # * <tt>access</tt> can be one of <tt>:view</tt>, <tt>:admin</tt> or <tt>:noaccess</tt>
      # * <tt>login</tt> is the user login on Piwik
      def give_access_to(access, login)
        Piwik::UsersManager.setUserAccess(:idSites => id, :access => access.to_s, :userLogin => login.to_s).data
      end
  end
end
