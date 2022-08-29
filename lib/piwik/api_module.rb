module Piwik
  class ApiModule < Base
    include Piwik::DataMethods

    # returns default API params, used all over the place, especially in <tt>scoped_methods</tt>
    def self.defaults
      { :period => :day, :date => Date.today }.tap do |defaults|
        defaults[@obj.id_attr] = @obj.id if @obj
      end
    end

    # Catch incoming method calls and try to format them and send them over to the api
    def self.method_missing(method, *args, &block)
      formatted_method = method.to_s.camelize(:lower)
      formatted_method = formatted_method.gsub(/ip$/i,'IP').gsub(/os/i,'Os') # Lame
      # connect to API if this is a valid-looking method in the current class context
      if @available_methods.include?(formatted_method)
        handle_api_call(formatted_method, args.first)
      else
        super
      end
    end

    # allows the addition of scoped methods. It's basically a class << self wrapper
    # mostly added to make ApiModule code more self-explanatory
    # the @obj instance variable is set in the api_scope call. This is not very clean or anything,
    # and I am still researching a better way to do it,
    # but the Piwik::Site API is certainly much better to work with due to this
    def self.scoped_methods &block
      if block_given?
        extension =  Module.new(&block)
        self.extend(extension)
      end
    end

    def self.available_methods method_array
      @available_methods = method_array
      @available_methods.each do |method|
        class_eval %{
          class #{self.api_call_to_const(method)} < Piwik::ApiResponse
          end
        }, __FILE__, __LINE__
      end
    end

    def self.api_call_to_const string, full = false
      # We can get rid of the get prefix
      string = case string
      # TODO: this regex is incorrect, it should be (get|add|delete|save) with parentheses
      # instead of [get|add|delete|save] with square brackets
      # but if I "fix" it 2 specs fail in spec/site_spec.rb
      when /[A-Z]{1}[a-z]*\.[get|add|delete|save]$/,'get','add','delete','save'
        string.camelize
      else
        string.gsub(/get|save|add|delete/, '')
      end
      string = string.split('.').map {|s| s.camelize }.join('::')
      full ? "Piwik::#{string}" : string
    end
  protected
    # Attempt an API call request
    def self.handle_api_call method, params
      method_name = "#{self.to_s.gsub('Piwik::','')}.#{method}"
      config = load_config_from_file
      config = config.merge(params.to_h.slice(:piwik_url, :auth_token)) if params
      xml = self.call(method_name, params, config[:piwik_url], config[:auth_token])
      data = (xml.is_a?(String) && xml.is_binary_data?) ? xml : XmlSimple.xml_in(xml, {'ForceArray' => false})
      if data.is_a?(String) && data.is_binary_data?
        api_call_to_const(method_name,true).constantize.new(:data => [], :value => data)
      elsif data.is_a?(String)
        api_call_to_const(method_name,true).constantize.new(:data => [], :value => data)
      elsif data['row'].present?
        api_call_to_const(method_name,true).constantize.new(:data => data['row'])
      elsif data.is_a?(Hash)
        api_call_to_const(method_name,true).constantize.new(:data => data)
      else
        api_call_to_const(method_name,true).constantize.new(:data => [])
      end
    end

    # Attempt an API call request
    def self.api_call method, params
      method_name = "#{self.to_s.gsub('Piwik::','')}.#{method}"
      config = load_config_from_file
      config = config.merge(params.to_h.slice(:piwik_url, :auth_token)) if params
      if params.is_a?(OpenStruct)
        params = params.marshal_dump
      end
      xml = self.call(method_name, params, config[:piwik_url], config[:auth_token])
      data = XmlSimple.xml_in(xml, {'ForceArray' => false})
      if data.is_a?(String)
        data
      elsif data['row'].present?
        data['row']
      elsif data.is_a?(Hash) and data['success'].is_a?(Hash)
        true
      elsif data.is_a?(Hash)
        data
      else
        []
      end
    end
  end
end
