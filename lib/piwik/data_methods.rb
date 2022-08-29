module Piwik
  # Provides a more intuitive interface to API responses.
  # Responses may return a value or structured data, and objects will figure out what kind or response they are getting,
  # and stick them in the appropriate instance variable.
  # Value responses are accessed directly:
  # Example:
  #
  #   Piwik::VisitsSummary.getVisits(:idSite => 7, :period => :day, :date => Date.today).value
  #   => 467
  #
  # Data Responses can be accessed either as a Hash or an object.
  # Example:
  #
  #   s = Piwik::API.getSettings
  #   => #<Piwik::API::Settings:[snip] @data={"SDK_batch_size"=>"10", "SDK_interval_value"=>"30"}>
  #   s.SDK_batch_size
  #   => 10
  #   s['SDK_batch_size']
  #   => 10
  #   s.data['SDK_batch_size']
  #   => 10
  module DataMethods
    def self.included(base)
      include Piwik::Typecast
      base.send(:include, InstanceMethods)
      attr_accessor :data,:value
    end

    module InstanceMethods
      def empty?
        data.blank? and value.blank?
      end

      def value
        typecast(@value)
      end

      def initialize opts = {}
        opts.map {|k,v| self.send(:"#{k}=",v) }
      end

      # try to pass method to the data variable
      def method_missing(method, *args, &block)
        if self.data.respond_to?(method)
          typecast(self.data.send(method,*args,&block))
        elsif self.data.is_a?(Hash) && self.data.key?(method.to_s)
          typecast(self.data[method.to_s])
        else
          super
        end
      end
    end
  end
end
