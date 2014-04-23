module Riskio
  class Base
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
      response = request(:post, @uri, data)
    end

    def update(id, data)
      response = request(:put, @uri + "/#{id}", data)
    end

    def delete(id)
      raise RiskioError.new("delete", @uri, nil, "Deletion is only implemented in some cases.")
    end

    private    

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