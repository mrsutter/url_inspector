module UrlInspector
  class HttpClient
    class << self
      def get(url)
        connection = connection(url)
        response = connection.get
        HttpClient::Response.new(response.status)
      rescue Faraday::Error
        HttpClient::Response.new
      end

      private

      def connection(url)
        params = {
          open_timeout: 10,
          timeout: 10
        }
        Faraday.new(url, request: params)
      end
    end
  end
end
