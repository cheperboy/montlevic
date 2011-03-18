class CreatePapiers < ActiveRecord::Migration
  def self.up
    create_table :papiers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :papiers
  end
end
