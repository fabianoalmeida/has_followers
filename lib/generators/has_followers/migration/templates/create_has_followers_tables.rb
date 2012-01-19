class CreateHasFriendsTables < ActiveRecord::Migration
  def self.up
    create_table :follows, :force => true do |t|
      t.references :user, :follower
      t.timestamps
    end
    
    add_index :follows, :user_id
    add_index :follows, :follower_id
    
    add_column :users, :followers_count, :integer, :default => 0, :null => false
    add_column :users, :following_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :users, :followers_count
    remove_column :users, :following_count
    
    drop_table :follows
  end
end