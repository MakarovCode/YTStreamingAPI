module YtStreamingApi
  module RApi
    class Request

      require 'uri'
      require 'net/https'
      require 'json'

      attr_accessor :url, :_url, :params, :user, :headers

      attr_reader :response, :http_verb, :error

      def initialize(user=nil)
        @user = user
      end

      def success?
        @error.nil? && !@response.nil?
      end

      def fail?
        !@error.nil?
      end

      private

      def url
        @url ||= _url
      end

      def reset_url
        @url = url
      end

      def http
        if http_verb == "Get"
          @url = "#{@url}#{@params}"
        end

        uri = URI.parse(@url)

        if @headers["Content-Type"] == "application/x-www-form-urlencoded"
          uri.query = URI.encode_www_form(@params)
        end

        puts "#{http_verb} #{@url}"
        https = Net::HTTP.new(uri.host,uri.port)

        https.use_ssl = true
        https.verify_mode = OpenSSL::SSL::VERIFY_NONE

        net_class = Object.const_get("Net::HTTP::#{http_verb}")
        request = net_class.new(uri, initheader = @headers)

        # request['Authorization']   = RApi.authorization

        unless @headers["Content-Type"] == "application/x-www-form-urlencoded"
          if http_verb != "Get"
            request.body = @params.to_json
          end
        end

        request = https.request(request)
        # llena @response ó @error
        puts "BODY =====> #{request.body}"

        @response = JSON.parse(request.body)

      end
    end
  end
end
