class HttpClient
  class << self
    def get(url)
      response = connection(url).get
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
