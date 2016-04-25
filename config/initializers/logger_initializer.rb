FileUtils.mkdir_p('log') unless Dir.exist?('log')

UrlInspector::Log.logger = Logger.new('log/main.log')
