module UrlInspector
  class ThreadPoolStrategy
    class InspectTask
      include UrlInspector::Log

      attr_reader :url, :normal_interval, :emergency_interval

      def initialize(options = {})
        @url = options[:url]
        @normal_interval = options[:normal_interval]
        @emergency_interval = options[:emergency_interval]
      end

      def call
        response = HttpClient.get(url)

        if response.success?
          interval = normal_interval
          log_success(url, interval)
        else
          interval = emergency_interval
          log_error(url, interval)
        end

        next_inspect_at = Time.now + interval
        { url => next_inspect_at }
      end
    end
  end
end
