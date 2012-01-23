module Has
  module Followers
    def self.included(base)
      base.extend Has::Followers::ClassMethods
    end
    
    module ClassMethods
      def has_followers
        include Has::Followers::InstanceMethods
        
        has_many :followed_to, :class_name => 'Follow', :foreign_key => 'user_id'
        has_many :follower_to, :class_name => 'Follow', :foreign_key => 'followed_id'
        has_many :followeds, :through => :followed_to, :source => :followed
        has_many :followers, :through => :follower_to, :source => :follower
      end
    end
    
    module InstanceMethods
      def follow(followed)
        unless following?(followed) || is?(followed)
          ActiveRecord::Base.transaction do
            Follow.create(:user_id => self.id, :followed_id => followed.id)
            increment_counters(followed)
          end
        end
      end
      
      def unfollow(followed)
        if following?(followed) && ! is?(followed)
          ActiveRecord::Base.transaction do
            follow = following_for(followed)
            unless follow.nil?
              follow.destroy
              decrement_counters(followed)
            end
          end
        end
      end
      
      def following?(followed)
        return follow = following_for(followed)
      end
      
      def following_for(followed)
        self.followeds.where( :id => followed.id ).first
      end
      
      def follow_me?(follower)
        return follow = followed_for(follower)
      end
      
      def followed_for(follower)
        self.followers.where( :id => follower.id ).first
      end
      
      def is?(followed)
        self.id.eql?( followed.id )
      end
      
      private
      def increment_counters(follower)
        self.update_attributes( { :followeds_count => self.followeds_count + 1 } )
        follower.update_attributes( { :followers_count => follower.followers_count + 1 } )
      end
      
      def decrement_counters(followed)
        self.update_attributes( { :followeds_count => self.followeds_count - 1 } )
        followed.update_attributes( { :followers_count => followed.followers_count - 1 } )
      end
    end
  end
end