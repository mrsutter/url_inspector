#!/usr/bin/env ruby

require './boot'
require_relative 'config/initializers/logger_initializer'

def urls_from_file(file)
  parser = UrlInspector::FileParser.new(file)
  parser.parse
end

def validate_intervals(normal_interval, emergency_interval)
  unless normal_interval > 0
    raise ArgumentError, 'Normal Interval must be a positive integer'
  end
  unless emergency_interval > 0
    raise ArgumentError, 'Emergency Interval must be a positive integer'
  end
end

def strategy_class(strategy_name)
  possible_strategies = %w(thread thread_pool)
  unless possible_strategies.include?(strategy_name)
    raise ArgumentError, "Strategy #{strategy_name} doesn't exist"
  end

  strategy_real_name = "#{strategy_name}_strategy"
  strategy_klass_name = strategy_real_name.split('_').map(&:capitalize).join
  strategy_klass_full_name = "UrlInspector::#{strategy_klass_name}"
  Object.const_get(strategy_klass_full_name)
end

def perform_strategy(strategy)
  puts 'Script is running'
  strategy.perform
rescue Interrupt
  puts 'Shutting down, please wait.....'
  strategy.shutdown if strategy
end

def process(options)
  urls = urls_from_file(options[:file])

  normal_interval = options[:normal_interval].to_i
  emergency_interval = options[:emergency_interval].to_i

  validate_intervals(normal_interval, emergency_interval)

  params = {
    urls: urls,
    normal_interval: normal_interval,
    emergency_interval: emergency_interval
  }

  strategy_name = options[:strategy_name]
  strategy = strategy_class(strategy_name).new(params)
  perform_strategy(strategy)
end

options = {
  file: ARGV[0],
  normal_interval: ARGV[1],
  emergency_interval: ARGV[2],
  strategy_name: ARGV[3]
}

options.each do |option_name, value|
  raise ArgumentError, "Please, specify #{option_name}" unless value
end

process(options)
