class AuthorsController < ApplicationController
	
	def index
		list
		render('list')
	end
	
	def list
		@authors = Author.sorted
		#@authors = Author.all
	end
	
	def show
		
		@books = Author.find(params[:author_id]).books
	end
	
	
end
