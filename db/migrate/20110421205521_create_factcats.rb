class CreateFactcats < ActiveRecord::Migration
  def self.up
    create_table :factcats do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :factcats
  end
end
