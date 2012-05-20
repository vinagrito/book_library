class WorkersController < ApplicationController
  	
	#@before_filter :confirm_worker
	def index
		list
		render('list')
	end
	
	def menu
  	end

    def list
    	
    	conditions = ['role_id = ?',params[:role_id]]
  		
  		@users = User.paginate :page => params[:page],:per_page => 50, :conditions => conditions
	end
	
	def show 
	end
	
  	
end
