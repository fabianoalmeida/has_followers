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
      @josh.should respond_to(:follow)
    end
    
    it "should respond to unfollow method" do
      @stuart.should respond_to(:unfollow)
    end
    
    it "should respond to following? method" do
      @kevin.should respond_to(:following?)
    end
    
    it "should respond to following_for method" do
      @bill.should respond_to(:following_for)
    end
    
    it "should respond to follow_me? method" do
      @josh.should respond_to(:follow_me?)
    end
    
    it "should respond to followed_for method" do
      @stuart.should respond_to(:followed_for)
    end
    
    it "should respond to followeds method" do
      @bill.should respond_to(:followeds)
    end
    
    it "should respond to followers method" do
      @josh.should respond_to(:followers)
    end
    
    it "should respond to is? method" do
      @stuart.should respond_to(:is?)
    end
  end
  
  describe "user" do
    before (:each) do
      @josh.follow(@stuart)
      @josh.follow(@kevin)
      @kevin.follow(@bill)
      @stuart.follow(@josh)
    end
    
    describe "'josh'" do
      it "should be yourself" do
        @josh.is?(@josh).should be_true
      end
      
      it "should not can follow yourself" do
        @josh.follow(@josh).should be_false
      end

      it "should have followeds count equals two" do
        @josh.followeds_count.should be(2)
      end

      it "should have followers count equals zero" do
        @josh.followers_count.should be(1)
      end

      it "should have two followeds" do
        @josh.followeds.should have(2).items
      end

      it "should have empty followers" do
        @josh.followers.should have(1).items
      end

      it "should be following 'stuart'" do
        @josh.following?(@stuart).should be_true
      end

      it "should not be following 'bill'" do
        @josh.following?(@bill).should be_false
      end

      it "should be been followed for 'stuart'" do
        @josh.followed_for(@stuart).should_not be_nil
      end

      it "should be been followed for 'stuart'" do
        @josh.follow_me?(@stuart).should be_true
      end

      it "should not be been followed for 'kevin'" do
        @josh.follow_me?(@kevin).should be_false
      end
    end
    
    describe "'kevin'" do
      describe "unfollowing 'bill'" do
        before (:each) do
          @kevin.unfollow(@bill)
        end
        
        after (:each) do
          @kevin.follow(@bill)
        end

        it "should have no followeds" do
          @kevin.followeds.should have(0).items
        end
        
        it "should have no followers" do
          @kevin.followers.should have(1).items
        end
        
        it "should have followers count equals zero" do
          @kevin.followers_count.should be(1)
        end
        
        it "should have followers count equals zero" do
          @kevin.followeds_count.should be(0)
        end
      end
    end
  end
end
