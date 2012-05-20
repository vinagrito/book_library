class AdminUsersController < ApplicationController
  
	#before_filter :authorized_person
	before_filter :find_role
	
	
	def index
		list
		render('list')
	end	
	
  	def list
  		conditions = ['role_id = ?',params[:role_id]]
  		#@users = User.where(:role_id => params[:role_id])	
  		#@users = User.find_admins
  		#@user ||= User.find_by_username(session[:username])
  		@users = User.paginate :page => params[:page],:per_page => 10, :conditions => conditions
  	end

  	def new
  		@user = User.new(params[:role_id])
  	end
  	
  	def create
  		flash[:notice] = 'User couldn\'t be created.'
  		unless params[:user][:password] != params[:user][:password_confirmation] 
  		   @user = User.new(params[:user])  		   
  		    if @user.save
  				flash[:notice] = "Administrator succesfully added!."
  				redirect_to(:action => 'list',:role_id => @role.id)  			
  		    else  				
  				render('new')
  			end   			
  		else  			
			render('new')
  		end	  		
  	end

  	def edit
  		@user = User.find(params[:id])
  	end
  	
  	def update
  		unless params[:user][:password] != params[:user][:password_confirmation]
  			@user = User.find_by_username(params[:user][:username])
  			if @user.update_attributes(params[:user])
  				flash[:notice] = "Administrator updated!."
  				redirect_to(:action => 'list',:role_id => @role.id) 
  			else
  				render('edit')
  			end
  		end
  		#flash[:notice] = "password don't match"
  		#render('edit')
  	end

	def password_update
		@user = User.find(params[:id])
	end
  	def delete
  		@user = User.find(params[:id])
  	end
  	
  	def destroy
  		@user = User.find(params[:id])
  		@user.destroy
  		flash[:notice] = "Administrator deleted!."
  		redirect_to(:action => 'list',:role_id => @role.id)
  	end
  	
  	def authorized_person
  		unless session[:role_id] == 1
  			session[:role_id] = nil
  			redirect_to(:controller => 'access')
  		end
  	end
	
  	def find_role
  		if params[:role_id]
  			@role = Role.find_by_id(params[:role_id])
  		end
  	end

end
