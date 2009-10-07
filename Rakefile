# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

PIDS=[]

namespace :selenium do
  
  desc "boot selenium"
  task :boot do
    PIDS << Kernel.fork do
      exec("java -jar #{ENV['SELENIUM_JAR']}")
    end
#    PIDS << $?.pid
  end
end

namespace :sinatra do
  desc "boot sinatra"
  task :boot do
    PIDS << Kernel.fork do
      exec("ruby sinatra_test_rig.rb")
    end
#    PIDS << $?.pid
  end
end

namespace :test do
  desc "execute all selenium tests"
  task :selenium do
     %w(selenium:boot sinatra:boot).each { |t| Rake::Task[t].execute }
    system("ruby test/selenium/load_test.rb")
    PIDS.each{|p| `kill #{p}`}
  end
end

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