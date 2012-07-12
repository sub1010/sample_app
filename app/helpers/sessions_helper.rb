module SessionsHelper   
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end   
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end  
  
  def current_user?(user)
    user == current_user
  end
  
  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)     
  end
  
  
   # Stores page request and redirects to the Sign In, if non-signed-in users try to access protected pages (Moved from the private section of the user controller so that the method can be used in the micropost controller as well)
  def signed_in_user 
    unless signed_in?
    store_location
    redirect_to signin_path, notice: "Please sign in." 
    end
  end
   
  
  #Redirects to the requested page of the non-signed-in user or to the default page, i.e. Profile Page
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  
  
  #Stores the location of the requested page of the non-signed-in user
  def store_location
    session[:return_to] = request.fullpath
  end
  
end
