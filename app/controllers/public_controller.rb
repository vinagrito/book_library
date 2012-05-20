class PublicController < ApplicationController
		
	before_filter :navigator
	layout 'public'
	
	def index
		list
		render('list')
	end	
	
	def list
		
	end
	
	def show
		
	end
	
	
	private
	
	def navigator
		@books = Book.sorted
		
	end
	
	
end
