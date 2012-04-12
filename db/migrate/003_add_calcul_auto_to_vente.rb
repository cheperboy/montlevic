class AddCalculAutoToVente < ActiveRecord::Migration
  def self.up
    add_column :ventes, :calcul_auto, :integer
    add_column :ventes, :unit, :string
    add_column :ventes, :poids_botte, :integer
  end

  def self.down
    remove_column :ventes, :calcul_auto
    remove_column :ventes, :unit
    remove_column :ventes, :poids_botte
  end
end
