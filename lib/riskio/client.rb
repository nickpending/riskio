module Riskio
  class Client
    
    # XXX - Yes, we will eventually move this to a Configuration class
    RISKIO_URI              = "https://api.risk.io/"
    RISKIO_AUTH_HEADER      = "X-Risk-Token"
    RISKIO_AUTH_TOKEN       = nil
    RISKIO_CONTENT_TYPE     = "application/json"

    RISKIO_ENDPOINTS        = { 
                                :asset            => "assets",
                                :vulnerability    => "vulnerabilities",
                                :tag              => "assets",
                                :patch            => "patches"
                              }
                              
    RISKIO_DEFAULTS         = [:riskio_uri, :riskio_auth_header, :riskio_auth_token, :riskio_content_type].freeze
    RISKIO_CLASSES          = [:asset, :vulnerability, :tag, :patch]

    attr_accessor           *RISKIO_DEFAULTS
    attr_accessor           *RISKIO_CLASSES
    
    def initialize(options={})
      
      # Setup our defaults
      # It would look something like this for each constant:
      # riskio_uri = options[:riskio_uri] || RISKIO_URI        
      RISKIO_DEFAULTS.each do |default|
        option = options[default] || Client.const_get(default.to_s.upcase)
        instance_variable_set(:"@#{default.to_s}", option)
      end           
      
      # The only default we cannot provide. Sorry.
      raise RiskioError.new(nil, @riskio_uri, nil, "Invalid Token") if @riskio_auth_token.nil?
      
      # Create a valid riskio header
      @header = {@riskio_auth_header => @riskio_auth_token, :accept => @riskio_content_type}
      
      # Create our objects
      RISKIO_CLASSES.each_with_index do |k|
        obj = Object::const_get("Riskio::#{k.to_s.capitalize}")
        instance_variable_set(:"@#{k.to_s}", obj.new(@riskio_uri + RISKIO_ENDPOINTS[k], @header))
      end
    end   
  end
end