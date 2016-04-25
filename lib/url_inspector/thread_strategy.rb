module UrlInspector
  class ThreadStrategy < Strategy
    attr_reader :threads

    def perform
      @threads = urls.map do |url|
        options = {
          url: url,
          normal_interval: normal_interval,
          emergency_interval: emergency_interval
        }
        Thread.new do
          inspector = Inspector.new(options)
          inspector.inspect
        end
      end
      threads.each(&:join)
    end

    def shutdown
      threads.each(&:kill)
    end
  end
end
