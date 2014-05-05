module Riskio
  class Connector < Base
    def initialize(uri, header)
      super(uri, header)
    end
    
    def upload(id, data)
        response = request(:post, @uri + "/#{id}/data_file", data)
    end
    
    def run(id)
      response = request(:get, @uri + "/#{id}/run")
    end
  end
end