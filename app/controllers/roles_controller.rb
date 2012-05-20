class RolesController < ApplicationController
	
	def index
		list
		render('list')
	end
	
	def list
		@users = User.where(:role_id => params[:role_id])
		#redirect_to(:controller => 'students',:users => @users)
	end
	
	
end
