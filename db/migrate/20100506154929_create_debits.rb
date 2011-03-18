class CreateDebits < ActiveRecord::Migration
  def self.up
    create_table :debits do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :debits
  end
end
