require "riskio/version"
require "riskio/client"
require "riskio/base"
require "riskio/asset"
require "riskio/vulnerability"
require "riskio/tag"
require "riskio/patch"
require "riskio/connector"

require "rubygems"
require "rest_client"
require "json"


module Riskio
  class RiskioError < StandardError
      attr_accessor :method, :uri, :response

      def initialize(method, uri, response, msg=nil)
        @method, @uri, @response = method, uri, response
        super("#{msg} #{@method} #{@uri} #{@response}")
      end
  end
end
