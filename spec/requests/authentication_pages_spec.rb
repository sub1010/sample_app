require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it { should have_selector('h1', text: 'Sign In')}
    it { should have_selector( 'title' , text: 'Sign In')}   
    
    describe "with invalid information" do
      
      before { click_button "Sign In"}
      
      it { should have_selector('title', text: 'Sign In')}
      it { should have_selector('div.alert.alert-error', text: 'Invalid')}  
      
      describe "after visiting another page" do
        before { click_link "Home"}
        it { should_not have_selector('div.alert.alert-error')}  
      end
      
    end
     
    
    describe "with valid information" do 
      let(:user) {FactoryGirl.create(:user)}
     
     before do
       fill_in "Email", with: user.name
       fill_in "Password" , with: user.password
       click_button "Sign In"
     end
     
     it { should have_selector('title', text: user.name)}
     it { should have_link('Profile', href: user_path(user))} 
     it { should have_link('Sign out' , href: signout_path)} 
     it { should_not have_link('Sign In', href: signin_path)} 
     
     describe "followed by signout" do
       before { click_link "Sign out"}    
       it { should have_link ('Sign In')}
     end
    
    end
    
  end                        
  
end
