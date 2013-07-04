class AddPrefSaisonToMyusers < ActiveRecord::Migration
  def self.up
    add_column :myusers, :pref_saison, :integer
  end

  def self.down
    remove_column :myusers, :pref_saison
  end
end
