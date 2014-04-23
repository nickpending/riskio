module Riskio
  class Tag < Base
    def initialize(uri, header)
      super(uri, header)
    end
    
    def update(id, data)
      response = request(:put, @uri + "/#{id}/tags", data)
    end
    
    def delete(id, data)
      response = RestClient::Request.execute( :method => :delete,
                                              :url => @uri + "/#{id}/tags",
                                              :payload => data,
                                              :headers => @header
                                            )
    end    
    
  end
end
