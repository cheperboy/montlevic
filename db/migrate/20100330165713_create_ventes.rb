class CreateVentes < ActiveRecord::Migration
  def self.up
    create_table :ventes do |t|
      t.integer :id
      t.integer :category_id
      t.integer :saison_id
      t.float :value

      t.timestamps
    end
  end

  def self.down
    drop_table :ventes
  end
end
