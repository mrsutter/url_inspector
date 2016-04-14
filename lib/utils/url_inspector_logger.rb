class UrlInspectorLogger < Logger
  class CustomFormatter < Logger::Formatter
    def call(severity, datetime, _progname, msg)
      formatted_datetime = datetime.strftime('%d.%m.%Y %H:%M:%S')
      thread_id = Thread.current.object_id
      "[#{formatted_datetime}] [#{thread_id}] [#{severity}] #{msg}\n"
    end
  end

  class << self
    attr_reader :instance

    def new(*args)
      @instance ||= super(*args)
    end
  end
end
