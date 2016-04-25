module UrlInspector
  module Log
    class CustomFormatter < Logger::Formatter
      def call(severity, datetime, _progname, msg)
        formatted_datetime = datetime.strftime('%d.%m.%Y %H:%M:%S')
        thread_id = Thread.current.object_id
        "[#{formatted_datetime}] [#{thread_id}] [#{severity}] #{msg}\n"
      end
    end

    def log_success(url, interval)
      msg = log_msg(url, interval)
      logger.info(msg)
    end

    def log_error(url, interval)
      msg = log_msg(url, interval)
      logger.error(msg)
    end

    private

    def log_msg(url, interval)
      "url=#{url} next_interval=#{interval}"
    end

    def logger
      @logger ||= Log.logger
    end

    class << self
      attr_reader :logger

      def logger=(logger)
        @logger = logger
        @logger.formatter = CustomFormatter.new
      end
    end
  end
end
