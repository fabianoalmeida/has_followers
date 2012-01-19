require 'has_followers/engine'
require 'has_followers/has_followers'

ActiveRecord::Base.send(:include, Has::Followers)