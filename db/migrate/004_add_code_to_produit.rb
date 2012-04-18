class AddCodeToProduit < ActiveRecord::Migration
  def self.up
    add_column :produits, :code, :string
    Produit.all.each do |p|
      p.update_attribute(:code, p.name.downcase.gsub(/\s/, '_'))
    end 
    
  end

  def self.down
    remove_column :produits, :code
  end
end
