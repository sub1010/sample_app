
class UsersController < ApplicationController
  
   def show
     @user = User.find(params[:id])
   end
   
   def new
     @user = User.new
   end
   
  def create
    @user = User.new(params[:user]) 
    if @user.save
       flash[:success] = "Welcome to the Sample App!"
      redirect_to @user  #alternate: render 'show' (show.html.erb). Shows profile page of new user
    else             
      render 'new'   # renders the new.html.erb template, after sign up fails
    
  end
  
  end 
     
end
