require "helper"

class TestClient < MiniTest::Unit::TestCase
  def setup()
    @token = "<insert your token here>"
    @asset_id = "<insert your asset id here>"
    @vulnerability_id = "<insert your vulnerability id here>"
    @client = Riskio::Client.new({:riskio_auth_token => @token})
  end
  
  def test_client_new()
    refute_nil(@client)
  end
  
  def test_client_defaults()
    assert_equal(@client.riskio_uri, "https://api.risk.io/")
    assert_equal(@client.riskio_auth_header, "X-Risk-Token")
  end
  
  def test_nil_api_token()
    assert_raises(Riskio::RiskioError)  { Riskio::Client.new() }
  end
  
  def test_not_found_request()
    assert_raises(Riskio::RiskioError) { @client.asset.show(0) }
  end
  
  def test_instance_variables()
    assert_respond_to(@client, :asset)
    assert_respond_to(@client, :vulnerability)
    assert_respond_to(@client, :tag)
    assert_respond_to(@client, :patch)
    assert_respond_to(@client, :riskio_uri)
    assert_respond_to(@client, :riskio_auth_header)
    assert_respond_to(@client, :riskio_auth_token)
    assert_respond_to(@client, :riskio_content_type)
  end
  
  def test_asset_create()
    asset = {:asset => { :primary_locator => "ip_address", :ip_address => "127.0.0.1"} }
    response = @client.asset.create(asset)
    data = JSON.parse(response)
    refute_nil(data["asset"]["id"])
    assert_equal(data["asset"]["primary_locator"], "ip_address")
  end
  
  def test_asset_create_invalid_locator()
    asset = {:asset => { :primary_locator => "ip", :ip_address => "127.0.0.1"} }
    response = @client.asset.create(asset)
    data = JSON.parse(response)
    puts response
    refute_nil(data["asset"]["id"])
    assert_equal(data["asset"]["primary_locator"], "ip_address")
  end
  
  def test_asset_create_invalid()
    #asset = {:asset => { :primary_locator => "ip_address", :ip_address => "127"} }
    #assert_raises(Riskio::RiskioError) {@client.asset.create(asset)}
  end
  
  def test_asset_show_valid()
    response = @client.asset.show(@asset_id)
    data = JSON.parse(response)
    assert_equal(data["asset"]["id"], @asset_id.to_i)
  end
  
  def test_asset_update_note()
    note = "This is a test note #{rand()}"
    asset = {:asset => {:notes => note} }
    response = @client.asset.update(@asset_id, asset)
    assert_equal(response.code, 204)
  end
  
  def test_asset_list_first_page()
    response = @client.asset.list(1)
    data = JSON.parse(response)
    assert_equal(data["meta"]["page"], 1)
  end
  
  def test_vulnerability_create()
    vuln = {:vulnerability => { :wasc_id => "WASC-01", :primary_locator => "ip_address", :ip_address => "127.0.0.1"} }
    response = @client.vulnerability.create(vuln)
    data = JSON.parse(response)
    assert_equal(data["vulnerability"]["wasc_id"], "WASC-01")
  end
  
  def test_vulnerability_show()
    response = @client.vulnerability.show(@vulnerability_id)
    data = JSON.parse(response)
    assert_equal(data["vulnerability"]["id"], @vulnerability_id.to_i)
  end
  
  def test_tag_valid_update()
    tag = {:asset => {:tags => "test"} }
    response = @client.tag.update(@asset_id, tag)
    assert_equal(response.code, 204)
  end
  
  def test_tag_delete()
    tag = {:asset => {:tags => "test"} }
    response = @client.tag.delete(@asset_id, tag)
    assert_equal(response.code, 204)
  end
  
end