
class UsersController < ApplicationController
   
   before_filter :signed_in_user, only: [:edit, :update, :index, :destroy ] 
   
   before_filter :correct_user , only: [:edit , :update] 
   
   before_filter :admin_user, only: [:destroy]
   
   #Shows all users of the App
   def index
   @users = User.paginate(page: params[:page])  
   end
   
   
   
   #Shows the profile page of the user
   def show  
     @user = User.find(params[:id])
   end
   
   def new
     @user = User.new
   end 
   
   #Pulls out the edit profile page for the user
   def edit     
   end  
   
   #If valid information is entered, it redirects to the updated profile page 
   def update    
     if @user.update_attributes(params[:user])
       flash[:sucess] = "Profile successfully updated!"     
       sign_in @user
       redirect_to @user
     else 
       render 'edit'
     end
     
   end
   
   #Signs up new users 
   def create  
    @user = User.new(params[:user]) 
    if @user.save 
       sign_in @user
       flash[:success] = "Welcome to the Sample App!"
      redirect_to @user  
    else             
      render 'new'   
    end  
   end
   
   
   #Gives admin users the ability to delete users from the app
   def destroy
     User.find(params[:id]).destroy
     flash[:success] = "User destroyed."
     redirect_to users_path
   end
      
  
 
 private
 
    # Stores page request and redirects to the Sign In, if non-signed-in users try to access protected pages
   def signed_in_user 
     unless signed_in?
     store_location
     redirect_to signin_path, notice: "Please sign in." 
     end
   end
   
   #Redirects to 'Home', if a wrong user tries to access protected pages
   def correct_user
     @user = User.find(params[:id])
     redirect_to(root_path) unless current_user?(@user)
   end
   
   #Redirects user to 'Home' if a non-admin user tries to delete another user from the command line
   def admin_user
    redirect to(root_path) unless current_user.admin?
  end
end
