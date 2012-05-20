class SubjectsController < ApplicationController
	
	#before_filter :setup_navigation	
	
	def index  	
  		list
  		render('list')
  	end

	def list
		@subjects = Subject.sorted
	end

  	def show
  		#@books = Book.order("books.name ASC")
  		@books = Book.find(params[:subject_id])  		
  	end
	
  	def new
  		@subject = Subject.new
  	end
  	
  	def create  		
  		@subject = Subject.new(params[:subject])
  		if @subject.save  			
  			flash[:notice] = 'Subject saved.'
  			redirect_to(:action => 'list')
  		else
  			flash[:notice] = 'Subject couldn\'t be saved.'
  			render('new')
  		end  			
  	end
	
	
	def setup_navigation
  		@subjects = Subject.sorted
  		@books = Book.sorted
    end
  	
end
