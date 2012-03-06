class AddAncestryToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :ancestry, :string
    add_index :categories, :ancestry
    
    tree_agri =   Category.new(:factcat_id => 10, :upcategory_id => 10, :name => 'Agricole', :code => 'agri').save!
    tree_maison = Category.new(:factcat_id => 10, :upcategory_id => 10, :name => 'Maison', :code => 'maison').save!
    tree_invest = Category.new(:factcat_id => 10, :upcategory_id => 10, :name => 'Investissement', :code => 'invest').save!
    
  end

  def self.down
    
    ['Agricole', 'Maison', 'Investissement'].each do |catname|
      cat = Category.find_by_name(catname)
      cat.destroy if cat
    end
    
    remove_index :categories, :ancestry  
    remove_column :categories, :ancestry
  end
end
