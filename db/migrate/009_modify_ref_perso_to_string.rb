class ModifyRefpersoToString < ActiveRecord::Migration
  def self.up
    change_column :ventes, :ref, :string
    change_column :factures, :ref, :string
    change_column :facdivs, :ref, :string
  end

  def self.down
  end
end


