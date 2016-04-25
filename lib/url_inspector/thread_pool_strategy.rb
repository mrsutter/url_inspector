module UrlInspector
  class ThreadPoolStrategy < Strategy
    def perform
      @pool = Concurrent::FixedThreadPool.new(pool_size)

      loop do
        tasks = urls_to_inspect.map { |url| InspectTask.new(task_params(url)) }
        task_runner = TaskRunner.new(tasks, @pool)
        results = task_runner.run!
        results.each { |result| scheduling_table.merge!(result) }
        scheduling_table
      end
    end

    def shutdown
      @pool.shutdown if @pool
    end

    private

    def urls_to_inspect
      scheduling_table
        .select { |_url, next_inspect_at| next_inspect_at <= Time.now }
        .keys
    end

    def scheduling_table
      @scheduling_table ||= Hash[urls.map { |url| [url, Time.now] }]
    end

    def pool_size
      @pool_size ||= config['main']['thread_pool_size']
    end

    def config
      @config ||= ::YAML.load_file('config/config.yml')
    end

    def task_params(url)
      {
        url: url,
        normal_interval: normal_interval,
        emergency_interval: emergency_interval
      }
    end
  end
end
