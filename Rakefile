# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
#require 'config/environment'
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

namespace :data do
  task :reset_db do
    sh %{rake db:drop}
    sh %{rake db:create}
    sh %{rake db:schema:load}
    sh %{rake db:seed}
  end

  desc "seed database from file saison_2010_2011.rb"
  task :saison_2011 => :environment do 
    file = File.join(Rails.root, 'db', 'datas', 'saison_2010_2011.rb')
    load(file) if File.exist?(file)
  end

  desc "seed database from file saison_2009_2010.rb"
  task :saison_2010 => :environment do 
    file = File.join(Rails.root, 'db', 'datas', 'saison_2009_2010.rb')
    load(file) if File.exist?(file)
  end

  desc "seed database from file test.rb"
  task :test => :environment do 
    file = File.join(Rails.root, 'db', 'datas', 'test.rb')
    load(file) if File.exist?(file)
  end

  desc "seed database from file seeds.rb : MY_FILE=seeds rake seed_from_file_bis"
  task :from_file => :environment do 
    FILE = ENV["MY_FILE"]
    file = File.join(Rails.root, 'datas', FILE)
    load(file) if File.exist?(file)
  end

  # desc "seed local db with file [filename].rb"
  # task :seed_from_file, [:filename] => [] do |t, args|
  #   # args.with_defaults( :filename => "seed_xxxx.rb")
  #   unless args.filename.nil?
  #     puts "seeding #{args.filename}.rb"
  #     file = File.join(Rails.root, 'db', 'seeds.rb')
  #     load(file) if File.exist?(file)
  #   else
  #     puts "filename empty"
  #   end
  # end
end
  
namespace :db do  
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

  task :get_timestamp do
    puts "time: #{Time.now.to_s}"
    t = Time.now.to_a
    timestamp = "#{t[5]}/#{t[4]}/#{t[3]}/#{t[2]}h#{t[1]}m#{t[0]}s"
    puts "timestamp: #{timestamp}"
  end
    
  # task :push_db, [:first_arg, :second_arg] do |args|
  #   # args.with_defaults(:first_arg => "Foo", :last_arg => "Bar")
  #   puts "First argument was: #{args.first_arg}"
  #   puts "Second argument was: #{args.second_arg}"    
  #   
    # sh %{ heroku pgbackups:restore --app montlevic DATABASE 'https://s3.amazonaws.com/comptagri/db_produits_ok.dump' }      
  # end  
end

