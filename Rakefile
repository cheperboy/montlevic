# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'


namespace :server do
  task :start do
    sh %{ script/server }
  end

  task :db do
    sh %{ su -l postgres }
    # sh %{ psql comptagri }
  end
end

namespace :db do
  task :get_timestamp do
    puts "time: #{Time.now.to_s}"
    t = Time.now.to_a
    timestamp = "#{t[5]}/#{t[4]}/#{t[3]}/#{t[2]}h#{t[1]}m#{t[0]}s"
    puts "timestamp: #{timestamp}"
  end
  
  task :test do
    sh "cd db"
    sh "mkdir dump_local" unless 
    sh "mkdir dump_distant"
    
  end
  
  desc "dump local db [db,filename]"
  task :dump_local, [:db, :filename] => [] do |t, args|
    directory "test/local"

    t = Time.now.to_a
    timestamp = "#{t[5]}/#{t[4]}/#{t[3]}"
    args.with_defaults( :db => "comptagri")
    args.with_defaults( :filename => "local_#{args.db}_#{timestamp}.dump")
    puts "dump database #{args.db} into  #{args.filename}"
    sh %{ pg_dump -Fc --no-acl --no-owner -h localhost -U postgres #{args.db} > #{args.filename}}      
  end
  
  # task :push_db, [:first_arg, :second_arg] do |args|
  #   # args.with_defaults(:first_arg => "Foo", :last_arg => "Bar")
  #   puts "First argument was: #{args.first_arg}"
  #   puts "Second argument was: #{args.second_arg}"    
  #   
    # sh %{ heroku pgbackups:restore --app montlevic DATABASE 'https://s3.amazonaws.com/comptagri/db_produits_ok.dump' }      
  # end  
end

