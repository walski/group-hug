class AddDefaultGroup < ActiveRecord::Migration
  def self.up
	add_column :users, :default_group, :string
  end

  def self.down
	remove_column :users, :default_group
  end
end
