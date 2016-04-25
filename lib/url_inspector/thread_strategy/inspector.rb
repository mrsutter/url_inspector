module UrlInspector
  class ThreadStrategy
    class Inspector
      include UrlInspector::Log

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
          response = HttpClient.get(url)

          if response.success?
            @interval = normal_interval
            log_success(url, interval)
          else
            @interval = emergency_interval
            log_error(url, interval)
          end

          sleep interval
        end
      end
    end
  end
end
