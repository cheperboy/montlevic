class AddSerialSumToSaisons < ActiveRecord::Migration
  def self.up
    add_column :saisons, :sum_charges, :text
    add_column :saisons, :sum_produits, :text
  end

  def self.down
    remove_column :saisons, :sum_charges
    remove_column :saisons, :sum_produits
  end
end
