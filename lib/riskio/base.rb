module Riskio
  class Base
    RISKIO_PRIMARY_LOCATOR              = [
                                            :ip_address,
                                            :hostname,
                                            :database,
                                            :url,
                                            :mac_address,
                                            :netbios,
                                            :fqdn
                                          ]
    
    
    def initialize(uri, header)
      @uri, @header = uri, header
    end
    
    def show(id)
      response = request(:get, @uri + "/#{id}")
    end

    def list(page=1)
      response = request(:get, @uri + "/?page=#{page}")
    end

    def create(data)
      # Find the primary_locator attribute
      locator = find_value(data, :primary_locator)
      
      # Raise error if it isn't included
      raise RiskioError.new("create", @uri, nil, "Primary locator is required.") if locator.nil?
      
      # Check to see if the locator is a valid label
      raise RiskioError.new("create", @uri, nil, "Primary locator is invalid.") unless RISKIO_PRIMARY_LOCATOR.include?(locator)
      
      response = request(:post, @uri, data)
    end

    def update(id, data)
      response = request(:put, @uri + "/#{id}", data)
    end

    def delete(id)
      raise RiskioError.new("delete", @uri, nil, "Deletion is only implemented in some cases.")
    end

    private
    
    # Find a key/value pair with :primary_locator label    
    def find_value(data, name)
      data.each_key do |key|
        # search for the key
        return data[key.to_sym].to_sym if key.to_sym == name.to_sym
        return find_value(data[key.to_sym], name) if data[key.to_sym].is_a?(Hash)
      end
      return nil
    end

    def request(method, uri, data=nil)
      begin
        case method
        when :get
          response = RestClient.send(method, uri, @header)
        else
          response = RestClient.send(method, uri, data, @header)
        end
      # XXX - Yes, I know, we are naughty
      rescue => e
        raise RiskioError.new(method, uri, e, "Unexpected failure making request.") 
      end
      response
    end
  end
end