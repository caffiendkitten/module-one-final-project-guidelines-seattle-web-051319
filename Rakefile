require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = nil #Logger.new(STDOUT)
  Pry.start
end

task :run do 
  game = JokeCLI.new
  game.run
end
