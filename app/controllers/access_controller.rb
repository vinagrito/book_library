class AccessController < ApplicationController
  
	#layout 'login'	
  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]
	
  	
	def index
  		login
  		render('login')
  	end
  	
  	def menu
  		# display links
  	end
	
	def login
  		#login form
  		session[:role_id] = 3
  		session[:username] = 'viewer'
  		session[:surname] = 'viewer'
  		session[:name] = 'viewer'
  		@all_roles ||= {'Administrator' => 1,'Student' => 3,'Worker' => 2}		
	end
	
	def attempt_login	
		#@info = params[:username].to_s + params[:password].to_s + params[:role_id].to_s
		@logged_user = User.authenticate(params[:username],params[:password],params[:role_id])		
		#redirect_to(:action => 'menu',:info => @info)
		if @logged_user
			session[:user_id] = @logged_user.id
			session[:name] = @logged_user.name
			session[:surname] = @logged_user.surname		
			session[:username] = @logged_user.username
			session[:role_id] = @logged_user.role_id
			flash[:notice] = 'You are logged in'			
			redirect_to(:action => 'menu')
		else
			flash[:notice] = 'Invalid username/password combination'
			redirect_to(:action => 'login')
		end
	end
	
	def logout
		session[:user_id] = nil
		session[:name] = nil
		session[:surname] = nil
		session[:username] = nil
		session[:role_id] = nil
		flash[:notice] = 'You have been logged out'
		redirect_to(:action => 'login')
	end
	
	
end
