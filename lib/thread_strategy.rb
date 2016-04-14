class ThreadStrategy < Strategy
  attr_reader :threads

  def perform
    @threads = urls.map do |url|
      options = {
        url: url,
        normal_interval: normal_interval,
        emergency_interval: emergency_interval
      }
      Thread.new { Inspector.new(options).inspect }
    end
    threads.each(&:join)
  end

  def shutdown
    threads.each(&:kill)
  end
end
