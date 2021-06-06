module YtStreamingApi
  module RApi
    class Broadcast < Request

      def list(part="snippet", status="active", type="all")
        @http_verb = 'Get'
        @url = "https://www.googleapis.com/youtube/v3/liveBroadcasts"
        @headers = {"Content-Type" => "application/json", "Authorization" => "#{RApi.authorization}#{@user.youtube_access_token}"}
        @params = "?part=#{part}&broadcastStatus=#{status}&broadcastType=#{type}&key=#{RApi.api_key}"

        http
        @response
      end

    end
  end
end
