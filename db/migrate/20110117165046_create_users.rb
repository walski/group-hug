class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :name, :facebook_id, :facebook_session_key
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
