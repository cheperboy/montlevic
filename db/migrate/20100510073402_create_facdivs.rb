class CreateFacdivs < ActiveRecord::Migration
  def self.up
    create_table :facdivs do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :facdivs
  end
end
