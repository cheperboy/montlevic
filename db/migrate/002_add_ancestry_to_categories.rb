class AddAncestryToCategories < ActiveRecord::Migration
  def self.up
    down
    # Structure
    # unless Category.column_names.find?('ancestry')
      add_column :categories, :ancestry, :string
      add_index :categories, :ancestry
    # end

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
    
    
    
    # test
    cat = Category.find(8)
    Category.new(:factcat_id => 40, :upcategory_id => 40, :name => 'toto', :code => 'toto').save!
    Category.find_by_factcat_and_upcategory(40,40).each do |toto|
      toto.update_attribute(:parent_id, cat.id)
    end
    
    
  end

  def self.down
    Category.all.each do |cat|
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

    # 2.times do 
    #   ['Agricole', 'Maison', 'Investissement'].each do |catname|
    #     cat = Category.find_by_name(catname)
    #     cat.destroy if cat
    #   end
    # end
    
    remove_index :categories, :ancestry # if Category.column_names.map(coancestry)?
    remove_column :categories, :ancestry
  end
end
