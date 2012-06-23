require 'spec_helper'

describe User do
  
  before  { @user= User.new(name: "Example User" , email: "user@example.com", password: "foobar" , password_confirmation: "foobar")}
  
  subject {@user}
  
  it { should respond_to(:name)  }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  
  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " "}
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " "}
    it { should_not be_valid }
  end
  
  describe "when the name is too long" do
    before { @user.name = "a"*51}
    it { should_not be_valid }
  end

  describe "when the email is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
   end
   
  end
 
  describe "when the email is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid    
      end
      
    end
    
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end
    
    it { should_not be_valid }
    
  end
  
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " "}
    it { should_not be_valid}
  end
  
  describe "when password does not match" do
    before {@user.password_confirmation = "mismatch"}
    it { should_not be_valid}
  end
  
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid}
  end
  
  describe "return value of the authenticate method" do
    before{ @user.save }
    let(:found_user){ User.find_by_email(@user.email) }
  end
    
    describe "when the password matches" do
      it{should == found_user.authenticate(@user.password)}
    end
    
    describe "when the password doesn't match" do
      let(:user_invalid_password){found_user.authenticate("invalid")}
      it { should_not == user_invalid_password }
      specify { user_for_invalid_password.should be_false }
      
    end
end
