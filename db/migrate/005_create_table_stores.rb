class CreateTableStores < ActiveRecord::Migration
  def self.up
    create_table :stores do |t|
      t.string :tag
      t.has_attached_file :file
    end
  end

  def self.down
    drop_attached_file :stores, :file
    drop_table :stores
  end
end