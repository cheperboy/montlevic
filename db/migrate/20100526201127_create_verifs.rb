class CreateVerifs < ActiveRecord::Migration
  def self.up
    create_table :verifs do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :verifs
  end
end
