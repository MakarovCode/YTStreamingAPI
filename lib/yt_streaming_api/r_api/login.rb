module YtStreamingApi
  module RApi
    class Login < Request

      def url
        "https://accounts.google.com/o/oauth2/auth?client_id=#{RApi.client_id}&redirect_uri=#{RApi.redirect_uri}&scope=#{RApi.scope}&response_type=#{RApi.response_type}&access_type=#{RApi.access_type}"
      end

      def is_valid_response(params)
        unless params[:code].blank?
          true
        else
          false
        end
      end

      def process_response_params(params)
        unless params[:code].blank?
          @user.youtube_authorization_token = params[:code]
          return params[:code]
        end
      end

      def get_tokens
        if @user.nil?
          return nil
        end
        if @user.youtube_authorization_token.nil?
          return nil
        end

        @http_verb = 'Post'
        @url = "https://accounts.google.com/o/oauth2/token"
        @headers = {"Content-Type" => "application/x-www-form-urlencoded"}

        @params = {
          code: @user.youtube_authorization_token,
          client_id: RApi.client_id,
          client_secret: RApi.client_secret,
          redirect_uri: RApi.redirect_uri,
          grant_type: "authorization_code"
        }

        http
        puts "===>#{@response}"
        process_tokens(@response)
      end

      def refresh_tokens
        if @user.nil?
          return nil
        end
        if @user.youtube_reset_token.nil?
          return nil
        end

        @http_verb = 'Post'
        @url = "https://accounts.google.com/o/oauth2/token"
        @headers = {"Content-Type" => "application/x-www-form-urlencoded"}

        @params = {
          refresh_token: @user.youtube_reset_token,
          client_id: RApi.client_id,
          client_secret: RApi.client_secret,
          grant_type: "refresh_token"
        }

        http
        puts "===>#{@response}"
        process_tokens(@response)
      end

      def process_tokens(res)
        @user.youtube_access_token = res["access_token"] unless res["access_token"].blank?
        @user.youtube_reset_token = res["refresh_token"] unless res["refresh_token"].blank?
        {access_token: res["access_token"], refresh_token: res["refresh_token"]}
      end

    end
  end
end
