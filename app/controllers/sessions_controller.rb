
class SessionsController < ApplicationController  
  
  def new
  end
  
  
  #If the signin details match the user in the DB, the user is signed in and redirected to...
  #...the requested page or to the default page, i.e. Profile Page
  
  def create  
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password]) 
      sign_in user    
      redirect_back_or user
    else 
      #Show error messages and reopen the sign_in page 
      flash.now[:error] = "Invalid email/password combination"
    render 'new'
    end
  end
  
  
  #Destroys the session of the current user and signs him/her out to the Home Page
  
  def destroy 
    sign_out
    redirect_to root_path
  end
  
end                                
