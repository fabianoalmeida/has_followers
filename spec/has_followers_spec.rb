require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "HasFollowers" do
  before (:each) do
    User.delete_all
    
    @josh   = User.create(:login => "josh")
    @stuart = User.create(:login => "stuart")
    @kevin  = User.create(:login => "kevin")
    @bill   = User.create(:login => "bill")
  end
  
  describe "methods" do
    it "should respond to has_followers method" do
      User.should respond_to(:has_followers)
    end
    
    it "should respond to follow method" do
      @josh.should respond_to(:be_follow)
    end
    
    it "should respond to unfollow method" do
      @stuart.should respond_to(:unfollow)
    end
    
    it "should respond to is_following? method" do
      @kevin.should respond_to(:is_following?)
    end
    
    it "should respond to following_for method" do
      @bill.should respond_to(:following_for)
    end
    
    it "should respond to is_my_follower? method" do
      @josh.should respond_to(:is_my_follower?)
    end
    
    it "should respond to follower_for method" do
      @stuart.should respond_to(:follower_for)
    end
    
    it "should respond to following method" do
      @bill.should respond_to(:following)
    end
    
    it "should respond to followers method" do
      @josh.should respond_to(:followers)
    end
  end
  
  describe "user" do
    before (:each) do
      #@josh.be_follow(@stuart)
      #do_follow(@josh, @kevin)
      #do_follow(@kevin, @bill)
    end
    
    it "should not have follows" do
      @josh.following.should be_empty
    end
    
    it "should have at least one following user" do
      @josh.following.should_not be_empty
    end
  end
    
  private
    def do_follow(user1, user2)
      user1.follow(user2)
      user2.follow(user1)
    end
    
    def do_unfollow(user1, user2)
      user1.unfollow(user2)
      user2.unfollow(user1)
    end
end
