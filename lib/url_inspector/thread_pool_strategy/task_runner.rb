module UrlInspector
  class ThreadPoolStrategy
    class TaskRunner
      def initialize(tasks, pool)
        @tasks = tasks
        @pool = pool
        @result_queue = Queue.new
      end

      def run!
        tasks
          .map(&wrap_with_result)
          .map(&schedule)
          .map(&await)
      end

      protected

      attr_reader :tasks, :result_queue, :pool

      private

      def wrap_with_result
        -> (task) { -> (*) { result_queue << task.call } }
      end

      def schedule
        -> (task) { pool.post([], &task) }
      end

      def await
        -> (*) { result_queue.pop }
      end
    end
  end
end
