# riskio
by Rudy Ruiz
* roodee [at] thummy [dot] com
* http://twitter.com/rudyruiz

## DESCRIPTION
Riskio is a lightweight Ruby wrapper around the Riskio REST API. The goal  It does not fully abstract the
underlying API, but it does not require you to send endpoints and other details for
each request. The wrapper user will still need to consult the Riskio REST API
documentation (http://api.riskio.com) to understand the required parameters and
options. Today this wrapper returns unprocessed JSON data.


### Riskio API 11-06-2013 and Riskio 0.3.0
Riskio 0.0.1 supports the Riskio API 11-06-2013 .

## USING Riskio

Before you do anything else, you'll need to
	require 'riskio'

Create your client:

	@client = Riskio::Client.new({:riskio_auth_token => "yourtokenhere"})

Assets:
	
	@client.asset.create({:asset => { :primary_locator => "ip_address", :ip_address => "127.0.0.1"} })
	@client.asset.show("yourassetid")
	@client.asset.list()
	@client.asset.list(2)
	
Vulnerabilities:

	@client.vulnerability.create({:vulnerability => { :wasc_id => "WASC-01", :primary_locator => "ip_address", :ip_address => "127.0.0.1"} })
	
Tags:

	@client.tags.update("yourassetid", {:asset => {:tags => "test"} })

## REQUIREMENTS

You'll need the following gems to use all features of riskio:
* json
* rest-client

### Ruby Version Support
Riskio is tested on 2.0.1

## TODO
1. Add validation for primary locators in base class
2. Create command-line utility
3. Add filter support for inactive assets

## INSTALL
riskio is available on rubygems.org. Just do the usual:

  gem install riskio