module Riskio
  class Asset < Base
    def initialize(uri, header)
      super(uri, header)
    end
    
    def find(*arguments)
      action   = arguments.slice(0)
      
      case action
        when :all   then  asset = find_all()
        else              asset = find_by_ip(*arguments)
      end
    end
    
    private
    
    def find_asset(ip)
      # Retrieve all assets, but issue find_all once
      @assets ||= find_all()

      # Search through our assets for a given IP address
      @assets.each do |asset|
        # Search for asset if not return nil
        if asset["primary_locator"].eql?("ip_address")
          return asset if asset["locator"].eql?(ip)
        end
      end
      # We didn't find a match
      return nil
    end
    
    def find_by_ip(*ips)
      raise RiskioError, "Missing parameter type (array) for find_some()" unless ips.kind_of?(Array)
      if ips.length == 1
        result = find_asset(ips.first)
      else
        result = find_some(ips)
      end
      result
    end
    
    def find_some(*ips)
      assets = []
      assets << ips.collect { |ip| find_asset(ip) }
    end
    
    def find_all()
      # Retrive initial list
      results = JSON.parse(list())
      
      # Extract the pages
      page = 2
      pages = results["meta"]["pages"]
      assets = results["assets"]
      
      # Retrieve all the other pages
      page.upto(pages) do |p|
        assets += JSON.parse(list("#{p}"))["assets"]
      end
      
      # Return all assets
      assets
    end
  end
end

