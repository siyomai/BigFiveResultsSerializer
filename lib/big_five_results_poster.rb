require 'net/http'
require 'net/https'
require 'uri'
require 'json'

class BigFiveResultsPoster
  attr_accessor :result, :uri, :header

  def initialize(result = {})
    @result = result
    @uri = URI.parse("https://recruitbot.trikeapps.com/api/v1/roles/mid-senior-web-developer/big_five_profile_submissions")
    @header = {'Content-Type': 'text/json'}
  end

  def post
    https = Net::HTTP.new(@uri.host, @uri.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(@uri.request_uri, header)
    request.body = @result.to_json
    response = https.request(request)
    response.code == "201" ? true : false
  end
end
