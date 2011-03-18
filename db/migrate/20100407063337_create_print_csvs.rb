class CreatePrintCsvs < ActiveRecord::Migration
  def self.up
    create_table :print_csvs do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :print_csvs
  end
end
