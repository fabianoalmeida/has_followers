class Follow < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :follower, :class_name => "User", :foreign_key => "follower_id"
  
  # callback
  after_destroy do |f|
    User.decrement_counter(:following_count, f.user_id)
    User.decrement_counter(:followers_count, f.follower_id)
  end
  
end