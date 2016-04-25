module UrlInspector
  class Strategy
    attr_reader :urls, :normal_interval, :emergency_interval

    def initialize(options = {})
      @urls = options[:urls]
      @normal_interval = options[:normal_interval]
      @emergency_interval = options[:emergency_interval]
    end

    def perform
    end

    def shutdown
    end
  end
end
