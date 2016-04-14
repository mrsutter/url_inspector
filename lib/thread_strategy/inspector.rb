class ThreadStrategy::Inspector
  attr_reader :url, :normal_interval, :emergency_interval
  attr_reader :interval

  def initialize(options = {})
    @url = options[:url]
    @normal_interval = options[:normal_interval]
    @emergency_interval = options[:emergency_interval]
    @interval = normal_interval
  end

  def inspect
    loop do
      response = ::HttpClient.get(url)

      if response.success?
        @interval = normal_interval
        log_success
      else
        @interval = emergency_interval
        log_error
      end

      sleep interval
    end
  end

  private

  def log_success
    msg = log_msg(normal_interval)
    logger.info(msg)
  end

  def log_error
    msg = log_msg(emergency_interval)
    logger.error(msg)
  end

  def log_msg(interval)
    "url=#{url} next_interval=#{interval}"
  end

  def logger
    ::UrlInspectorLogger.instance
  end
end
