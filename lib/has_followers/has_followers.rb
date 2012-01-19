module Has
  module Followers
    def self.included(base)
      base.extend Has::Followers::ClassMethods
    end
    
    module ClassMethods
      def has_followers
        include Has::Followers::InstanceMethods
        
        has_many :following, :class_name => "Follow", :source => :user,     :conditions => { :user_id => :id }
        has_many :followers, :class_name => "Follow", :source => :follower, :conditions => { :follower_id => :id }
      end
    end
    
    module InstanceMethods
      def be_follow(follower)
        ActiveRecord::Base.transaction do
          self.following.create(:follower_id => follower.id)
          increment_counters(follower)
        end
      end
      
      def unfollow(follower)
        ActiveRecord::Base.transaction do
          if is_following?(follower)
            following_for(follower)
            follow.destroy
          end
        end
      end
      
      def is_following?(follower)
        follow = following_for(follower)
        ! follow.nil?
      end
      
      def following_for(follower)
        following.first :conditions => { :follower_id => follower.id }
      end
      
      def is_my_follower?(user)
        follow = follower_for(user)
        !!(follow)
      end
      
      def follower_for(user)
        following.first :conditions => { :user_id => user.id, :follower_id => self.id }
      end
      
      private
      def increment_counters(follower)
        User.increment_counter(:following_count, self.id)
        User.increment_counter(:followers_count, follower.id)
      end
    end
  end
end