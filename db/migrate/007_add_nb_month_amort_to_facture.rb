class AddNbMonthAmortToFacture < ActiveRecord::Migration
  def self.up
    add_column :factures, :nb_month_amort, :integer
  end

  def self.down
    remove_column :factures, :nb_month_amort
  end
end
