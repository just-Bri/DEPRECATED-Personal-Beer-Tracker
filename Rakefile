ENV["SINATRA_ENV"] ||= "development"
require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc 'Launch console'
  task :console do
    require 'irb'
    require 'irb/completion'
    ARGV.clear
    IRB.start
  end

# Type `rake -T` on your command line to see the available rake tasks.
