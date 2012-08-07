#!/usr/bin/env rake
require "bundler/gem_tasks"

desc "Open an irb session preloaded with this library"
task :console do
  sh "bundle exec irb -rubygems -I lib -r laundry.rb"
end

task :default => [:travis]
task :travis do
  
end
