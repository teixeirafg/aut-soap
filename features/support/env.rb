require 'rspec'
require 'savon'
require 'parallel_tests'
require 'pry'
require 'faker'
require 'rake'
require 'cpf_faker'
require 'brstring'
require 'erubi'

Dir[File.join(File.dirname(__FILE__), 'commons/*.rb')].sort.each { |file| require_relative file }
Dir[File.join(File.dirname(__FILE__), 'spec_helper/*.rb')].sort.each { |file| require_relative file }

ENVIRONMENT = ENV['AMBIENTE']

BANDEIRA = ENV['BANDEIRA']

ENDPOINTS = YAML.load_file(File.dirname(__FILE__) + "/config/#{BANDEIRA}/urls.yml")
PATH_MASSA = File.dirname(__FILE__) + "/massa/#{BANDEIRA}/#{ENVIRONMENT}"

SAVON_LOG = ENV['SAVON_LOG'].eql?('true') ? :debug : :error

World(Commons, CommonsServices, SoapAPI)
