
module YtStreamingApi
  module RApi
    class Message < Request

      def list(part="snippet", max_results=2000, chat_id=nil)
        return nil if chat_id.nil?
        
        @http_verb = 'Get'
        @url = "https://www.googleapis.com/youtube/v3/liveBroadcasts"
        @headers = {"Content-Type" => "application/json", "Authorization" => "#{RApi.authorization}#{@user.youtube_access_token}"}
        @params = "?liveChatId=#{chat_id}&part=#{part}&maxResults=#{max_results}&key=#{RApi.api_key}"

        http
        @response
      end

    end
  end
end
