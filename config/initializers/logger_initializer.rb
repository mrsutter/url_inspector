FileUtils.mkdir_p('log') unless Dir.exist?('log')

logger = UrlInspectorLogger.new('log/main.log')
logger.formatter = UrlInspectorLogger::CustomFormatter.new
