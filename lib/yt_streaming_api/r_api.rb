module YtStreamingApi
  module RApi
    class << self
      require "base64"
      # NOTA: definir si dejar estos campos como accessors
      attr_accessor :api_key, :client_id, :client_secret, :redirect_uri, :response_type, :scope, :access_type
      attr_reader

      # recibe un bloque inicializador de variables de configuración de payu como la
      # api_key, api_login
      def configure(&block)
        block.call(self)
      end

      # genera el codigo de autenticación que será enviado en los header de todas las peticiones a la api
      def authorization
        @authorization ||= "Bearer "
      end
    end
  end
end
