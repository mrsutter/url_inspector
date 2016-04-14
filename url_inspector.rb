#!/usr/bin/env ruby

require './boot'
Dir[File.dirname(__FILE__) + '/config/**/*.rb'].each { |file| require file }

file_name = ARGV[0]
urls = FileParser.new(file_name).parse

raise ArgumentError, 'Please, specify normal interval' unless ARGV[1]
raise ArgumentError, 'Please, specify emergency interval' unless ARGV[2]

normal_interval = ARGV[1].to_i
emergency_interval = ARGV[2].to_i

unless normal_interval > 0
  raise ArgumentError, 'Normal Interval must be a positive integer'
end
unless emergency_interval > 0
  raise ArgumentError, 'Emergency Interval must be a positive integer'
end

strategy_name = ARGV[3]
possible_strategies = %w(thread thread_pool)
raise ArgumentError, 'Please, specify inspecting strategy' unless strategy_name
unless possible_strategies.include?(strategy_name)
  raise ArgumentError, "Strategy #{strategy_name} doesn't exist"
end

strategy_real_name = "#{strategy_name}_strategy"
strategy_klass_name = strategy_real_name.split('_').map(&:capitalize).join
klass = Object.const_get(strategy_klass_name)

params = {
  urls: urls,
  normal_interval: normal_interval,
  emergency_interval: emergency_interval
}

strategy = klass.new(params)

begin
  puts 'Script is working'
  strategy.perform
rescue Interrupt
  puts 'Shutting down, please wait.....'
  strategy.shutdown
end
