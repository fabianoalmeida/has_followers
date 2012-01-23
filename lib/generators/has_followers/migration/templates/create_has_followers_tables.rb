class CreateHasFollowersTables < ActiveRecord::Migration
  def self.up
    create_table :follows, :force => true do |t|
      t.references :followed, :user
      t.timestamps
    end
    
    add_index :follows, :followed_id
    add_index :follows, :user_id
    
    add_column :users, :followers_count, :integer, :default => 0, :null => false
    add_column :users, :followeds_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :users, :followers_count
    remove_column :users, :followeds_count
    
    drop_table :follows
  end
end