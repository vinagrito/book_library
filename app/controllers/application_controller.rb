class ApplicationController < ActionController::Base
  protect_from_forgery    
  
  	#before_filter :confirm_logged_in
  	
  	def password_edit
  		@user = User.find(params[:user_id])
  		#redirect_to(:partial => 'shared/password_form')
  	end
  	
  	def password_update
  		@user = User.find(params[:user_id])  		
  		
  		if @user.password_match?(params[:user][:password]) && 
  			params[:user][:new_password] == params[:user][:password_confirmation]
  			
  			@user.update_attributes(:password => params[:user][:new_password])
  			flash[:notice] = 'Password successfully changed'
  			
  				redirect_to(:controller => 'access', :action => 'menu')  			
  							
  			
  		else
  			flash[:notice] = 'Password couldn\'t be updated.'
  			render('password_edit')
  		
  		end
  	end
  	  	
  	helper_method :admin?
  	helper_method :worker?
  	helper_method :student? 
  
   protected
    
  
        
    def confirm_admin
    	unless session[:role_id] == 1 
    		flash[:notice] = "Please login in as an administrator to see this page"
    		redirect_to :controller => 'access', :action => 'logout'
    		return false
    	else
    		return true
		end    	
	end
	
	def confirm_worker
		unless session[:role_id] == 2 
    		flash[:notice] = "Please login in as a worker to see this page"
    		redirect_to :controller => 'access', :action => 'logout'
    		return false
    	else
    		return true
		end    
	end
	
	def confirm_logged_in
		unless session[:user_id]
			flash[:notice] = "Please log in"
			redirect_to(:controller =>"access", :action => 'login')			
			return false # halts the before_filter
		else
			return true
		end
	end	
	
	def admin?
		if session[:role_id] == 1 
			true
		else
			false
		end
	end
	
	def worker?
		if session[:role_id] == 2 
			true
		else
			false
		end
	end
	
	def student?
		if session[:role_id] == 3 
			true
		else
			false
		end
	end
  
	
  	
end
