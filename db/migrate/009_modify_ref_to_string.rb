# modify ref_perso (called ref in db) to string. was integer.

class ModifyRefToString < ActiveRecord::Migration
  def self.up
    change_column :ventes, :ref, :string
    change_column :factures, :ref, :string
    change_column :facdivs, :ref, :string
  end

  def self.down
  end
end


