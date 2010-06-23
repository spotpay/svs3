# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

FLEX_ROOT = "#{File.dirname(__FILE__)}/.." unless defined?(FLEX_ROOT)
require File.expand_path(File.join(File.dirname(__FILE__), "config/dependencies.rb"))
require 'tasks/flex_linker'


namespace :git do
  namespace :branch do

    desc "Sets up a git branch"
    task :setup do
      branch_name = ENV['branch'] || ENV['BRANCH']
      unless branch_name.nil?
        puts `git fetch origin #{branch_name}:#{branch_name}`
        puts `git checkout #{branch_name}`
        puts `git config --global branch.#{branch_name}.merge refs/heads/#{branch_name}`
        puts `git config --global branch.#{branch_name}.remote origin`
      else
        puts "Error: No branch name specified. Use rake git:branch:setup branch=<branch name>"
      end
    end

    desc "Creates a new local branch and pushes it to origin"
    task :create do
      branch_name = ENV['branch'] || ENV['BRANCH']
      unless branch_name.nil?
        puts `git branch #{branch_name}`
        puts `git push origin #{branch_name}:#{branch_name}`
      else
        puts "Error: No branch name specified. Use rake git:branch:create branch=<branch name>"
      end
    end
    
  end
end

namespace :spotpay do
  namespace :svs3 do
    desc "Copies config/<env>.as config file into app/ and starts compiling. ex: rake wp:ui env=test"
    task :build do
      env = ENV['env'] || "development"
      sh "cp config/#{env}.as app/Config.as"
      sh "ant build"
      sh "cp ./bin/SVS3.swf ../../pineapple/public/widgetpay_client/"    
    end
  end
end