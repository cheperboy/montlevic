
# rake db:reset
# eventuellement remettre les associations dans category.rb (belongs_to :factcat et :upcategory) 
# pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d comptagri_dev doc/export_heroku/b010.dump
# commenter l'appel a "has_ancestry" dans category.rb
# rake db:migrate:up VERSION=1 --trace
# remettre l'appel a "has_ancestry" dans category.rb
# rake db:migrate:up VERSION=2 --trace

class AddAncestryToCategories < ActiveRecord::Migration
  def self.up
    # down
    say "Running Version=2 up"
    # Structure
      add_column  :categories, :ancestry, :string
      add_index   :categories, :ancestry
      # add_column  :categories, :ancestry_depth, :integer, :default => 0
      # change_column :categories, :factcat_id, :integer
      # change_column :categories, :upcategory_id, :integer

    if true
      # Datas
      Factcat.all.each do |factcat|   #['Agricole', 'Maison', 'Investissement']
        Category.create!(:factcat_id => 20, :upcategory_id => 20, :name => factcat.name, :code => factcat.code).save!
      end

      tree_agri = Category.find(:first, :conditions => { :name => "Agricole" })
      Category.find_by_factcat_and_upcategory(1,1).each do |cat|
        cat.update_attribute(:parent_id, tree_agri.id)
      end
      tree_maison = Category.find(:first, :conditions => { :name => "Maison" })
      Category.find_by_factcat_and_upcategory(2,1).each do |cat|
        cat.update_attribute(:parent_id, tree_maison.id)
      end    
      tree_invest = Category.find(:first, :conditions => { :name => "Investissement" })
      Category.find_by_factcat_and_upcategory(3,1).each do |cat|
        cat.update_attribute(:parent_id, tree_invest.id)
      end


      Upcategory.all.each do |upcat| #facture, pulve, labour, vente
        Category.new(:factcat_id => 10, :upcategory_id => 10, :name => upcat.name, :code => upcat.name).save!
      end

      facture = Category.find(:first, :conditions => { :name => "facture", :upcategory_id => 10})
      Category.find_by_factcat_and_upcategory(20,20).each do |cat|
        cat.update_attribute(:parent_id, facture.id)
      end

      produit = Category.find(:first, :conditions => { :name => "produit", :upcategory_id => 10})
      Category.find_by_factcat_and_upcategory(1,2).each do |cat|
        cat.update_attribute(:parent_id, produit.id)
      end
      labour = Category.find(:first, :conditions => { :name => "labour", :upcategory_id => 10})
      Category.find_by_factcat_and_upcategory(1,3).each do |cat|
        cat.update_attribute(:parent_id, labour.id)
      end
      vente = Category.find(:first, :conditions => { :name => "vente", :upcategory_id => 10})
      Category.find_by_factcat_and_upcategory(1,4).each do |cat|
        cat.update_attribute(:parent_id, vente.id)
      end
      pulve = Category.find(:first, :conditions => { :name => "pulve", :upcategory_id => 10})
      Category.find_by_factcat_and_upcategory(1, 5).each do |cat|
        cat.update_attribute(:parent_id, pulve.id)
      end
    end #en of "if true"
    
    # fill the ancestry_depth column
    # Category.rebuild_depth_cache!
    
    Category.all.each do |cat|
      cat.update_attribute(:name, cat.name.camelize)
    end
    
    # test
    cat = Category.find(8)
    Category.new(:factcat_id => 40, :upcategory_id => 40, :name => 'toto', :code => 'toto').save!
    Category.find_by_factcat_and_upcategory(40,40).each do |toto|
      toto.update_attribute(:parent_id, cat.id)
    end

  end

  def self.down
    say "Running Version=2 down"
    Category.all.each do |cat|
      say "cat.update to nil #{cat.id}"
      cat.update_attribute(:ancestry, nil)
    end
    
    Category.find_by_factcat_and_upcategory(10,10).each do |cat|
      say "deleted #{cat.name}"
      cat.destroy
    end
    Category.find_by_factcat_and_upcategory(20,20).each do |cat|
      say "deleted #{cat.name}"
      cat.destroy
    end
    Category.find_by_factcat_and_upcategory(40,40).each do |cat|
      say "deleted #{cat.name}"
      cat.destroy
    end
    
    say "remove_index :categories, :ancestry"
    remove_index :categories, :ancestry # if Category.column_names.map(coancestry)?
    remove_column :categories, :ancestry
    # remove_column :categories, :ancestry_depth

    # change_column :categories, :factcat_id, :integer, :null => false
    # change_column :categories, :upcategory_id, :integer, :null => false
    
  end
end
