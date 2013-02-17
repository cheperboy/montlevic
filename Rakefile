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

  # Jamais utilise mais peut etre utile apres import de pulves pour mettre a jour les stocks
  desc "update les protofacture.stock de chaque saison"
  task :update_protofacture_stock => :environment do 
    Saison.all.each do |s|
      s.produits.each do |produit|
        produit.update_protofacture_stock
      end
    end
  end

  desc "seed database from file saison_2013.rb"
  task :create_saison_2013 => :environment do 
    file = File.join(Rails.root, 'db', 'datas', 'saison_2013.rb')
    load(file) if File.exist?(file)
  end

  desc "seed database from file test.rb"
  task :test => :environment do 
    sh %{rake db:drop}
    sh %{rake db:create}
    sh %{rake db:schema:load}
    sh %{rake db:seed}
    file = File.join(Rails.root, 'db', 'datas', 'test.rb')
    load(file) if File.exist?(file)
  end

  desc "seed database from file seeds.rb : MY_FILE=seeds rake seed_from_file_bis"
  task :from_file => :environment do 
    FILE = ENV["MY_FILE"]
    file = File.join(Rails.root, 'datas', FILE)
    load(file) if File.exist?(file)
  end

  # ATTENTION supprime une saison et ses parcelles !
  desc "ATTENTION supprime une saison et ses parcelles !"
  task :delete_saison_2013 => :environment do 

    # _______________________________________
    #  ATTENTION                            \
    #  CE CODE SUPPRIME                     \
    #   - UNE SAISON (model saison)         \
    #   - LES PARCELLES DE LA SAISON        \
    #                                       \
    # DECOMMANTER LE CODE POUR UTILISER     \
    # ______________________________________\

    # Choix de la Saison
    saison = Saison.find_by_year('2013')
    name = saison.name

    if (saison.factures.count>0 || saison.pulves.count>0 || saison.ventes.count>0)
      puts "LA SAISON POSSEDE DES OBJETS vente ou facture ou pulve"
      puts "PAS DE DESTRUCTION !"
    else    
      # DESTRUCTION DES PARCELLES
      # detruit aussi les zonetopas car 
      puts "delete : "

      saison.parcelles.each do |parcelle|
        puts "\t parcelle #{parcelle.name}, #{parcelle.surface}"
        parcelle.destroy # call destroy because deletes also dependant (zonetopas). delete method does not.
      end

      # DESTRUCTION DE LA SAISON
      saison.delete

      puts "LA SAISON #{name} ET SES PARCELLES SONT SUPPRIMEES"

    end
  end

end
  
namespace :db do  
  # desc "dump local db [db,filename]"
  # task :dump_local_old, [:db, :filename] => [] do |t, args|
  #   directory "test/local"
  #   t = Time.now.to_a
  #   timestamp = "#{t[5]}/#{t[4]}/#{t[3]}"
  #   args.with_defaults( :db => "comptagri_dev")
  #   args.with_defaults( :filename => "local_#{args.db}_#{timestamp}.sql")
  #   puts "dump database #{args.db} into  #{args.filename}"
  #   sh %{ cat pg_dump -Fc --no-acl --no-owner -h localhost -U postgres #{args.db} > #{args.filename}}      
  #   sh %{ pg_dump -Fc --no-acl --no-owner -h localhost -U postgres #{args.db} > #{args.filename}}      
  # end

  desc "dump local db comptagri_dev"
  task :dump_local => :environment do 
    t = Time.now.to_a
    timestamp = "#{t[5]}-#{t[4]}-#{t[3]}-#{t[2]}h#{t[1]}m#{t[0]}s"
    db = "comptagri_dev"
    filename = "doc/export/local_#{db}_#{timestamp}.sql"
    puts "dump database #{db} into #{filename}"
    command = "pg_dump -v --no-acl --no-owner -h localhost -U postgres #{db} > #{filename}"
    sh %{ #{command} }
    # sh %{ echo '#{command}' > #{filename} }
  end
  
  # a supprimer, effectuer une fois en prod pour rendre les category.code uniques
  desc "rename cats code if invalid"
  task :rename_cats => :environment do 
    Category.all.each do |c|
      unless c.valid?
        if c.errors[:code]
          puts "#{c.code}"
          c.errors.each {|e| puts "\t#{e.inspect}"}
          c.old_code = c.code
          new_code = "#{c.parent.code}.#{c.code}"
          c.code = new_code
          if c.valid?
            c.save!
          else
            puts "APRES: #{c.code}"
            c.errors.each {|e| puts "\t#{e.inspect}"}
          end
        end
      end
      c.save
    end
  end

end

