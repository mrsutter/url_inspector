require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'logger'
require 'yaml'

Dir[File.dirname(__FILE__) + '/lib/utils/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/lib/utils/http_client/*.rb'].each { |file| require file }

require_relative 'lib/strategy'
require_relative 'lib/thread_strategy'
Dir[File.dirname(__FILE__) + '/lib/thread_strategy/*.rb'].each { |file| require file }
require_relative 'lib/thread_pool_strategy'
Dir[File.dirname(__FILE__) + '/lib/thread_pool_strategy/*.rb'].each { |file| require file }
