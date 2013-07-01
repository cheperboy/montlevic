class CreateTableVentoproduits < ActiveRecord::Migration
  def self.up
    create_table :ventoproduits do |t|
      t.integer :saison_id
      t.integer :produit_id
      t.integer :vente_id
      t.float :value
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :ventoproduits
  end
end
