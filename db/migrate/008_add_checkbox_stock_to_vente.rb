class AddCheckboxToVente < ActiveRecord::Migration
  def self.up
    add_column :ventes, :stock, :integer
  end

  def self.down
    remove_column :ventes, :stock
  end
end
