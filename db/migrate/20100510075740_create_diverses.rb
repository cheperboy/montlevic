class CreateDiverses < ActiveRecord::Migration
  def self.up
    create_table :diverses do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :diverses
  end
end
