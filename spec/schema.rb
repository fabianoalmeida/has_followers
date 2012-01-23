ActiveRecord::Schema.define(:version => 0) do
  begin
    drop_table :users
    drop_table :follows
  rescue
  end
  
  create_table :users do |t|
    t.string :login
    t.integer :followeds_count, :default => 0, :null => false
    t.integer :followers_count, :default => 0, :null => false
  end
  
  create_table :follows do |t|
    t.references :followed, :user
    t.timestamps
  end
end