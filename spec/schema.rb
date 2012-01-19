ActiveRecord::Schema.define(:version => 0) do
  begin
    drop_table :users
    drop_table :follows
  rescue
  end
  
  create_table :users do |t|
    t.string :login
    t.integer :following_count, :default => 0, :null => false
    t.integer :followers_count, :default => 0, :null => false
  end
  
  create_table :follows do |t|
    t.references :user, :follower
    t.timestamps
  end
end