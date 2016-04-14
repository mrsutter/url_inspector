class HttpClient::Response
  attr_reader :status

  def initialize(status = nil)
    @status = status
  end

  def success?
    return false if status.nil?
    status.between?(200, 209) || status.between?(300, 309)
  end
end
