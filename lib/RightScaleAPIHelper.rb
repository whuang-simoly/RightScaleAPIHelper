module RightScaleAPIHelper
  class Helper
    # The aim of this class is to help access the RightScale API.
    # The goal is to include this in programs so that you can then use the api
    # without the need for all of the heavy lifting.

    # This currently only works with version 1.0 of the api. This is because it is all we currently
    # use. Will probably need to make it smarter at some point, but this is just for
    # some internal use as of now.

    require 'net/http'
    require 'net/https'

# Initialize the connection. Provide headers for later use
    def initialize(account, username, password, format = 'xml')
      # Set Default Variables
      rs_url = "https://my.rightscale.com"
      api_url = '/api/acct/'
      @api_call = "#{api_url}#{account}"
      @full_api_call = "#{rs_url}#{@api_call}"
      @formatting = "?format=#{format}"
      @conn = Net::HTTP.new('my.rightscale.com', 443)
      @conn.use_ssl=true
      #@conn.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Get.new("#{@full_api_call}/login?api_version=1.0")
      req.basic_auth( username, password )
      resp = @conn.request(req)
      if resp.code.to_i != 204
        puts resp.code
        raise("Failed to authenticate user.\n Http response code was #{resp.code}.")
      end
      cookie = resp.response['set-cookie']
      #puts "The response code was #{resp.code}"

      @headers = {
          "Cookie" => cookie,
          "X-API-VERSION" => "1.0",
          #"api_version" => "1.0",
      }
    end

    def get(query)
      begin
        puts "#{@api_call}#{query}#{@formatting}"
        resp = @conn.get("#{@api_call}#{query}#{@formatting}", @headers)
      rescue
        raise("Get query failed.\nError: #")
      end
      return resp
    end

    def post(query, values)
      req = Net::HTTP::Post.new("#{@full_api_call}#{query}", @headers)

      req.set_form_data(values)
      resp = @conn.request(req)

      return resp
    end

    def delete(query)
      req = Net::HTTP::Delete.new("#{@full_api_call}#{query}", @headers)
      resp = @conn.request(req)
    end

    def put(query, values)
      req = Net::HTTP::Put.new("#{@full_api_call}#{query}", @headers)
      req.set_form_data(values)
      resp = @conn.request(req)
    end
  end
end