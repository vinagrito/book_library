class BooksController < ApplicationController
	
	#layout 'public'
	#before_filter :find_subject	
	
	def index		
		list
		render('list')
	end
	
	def list
		@conditions = ['1=1']
		case
			when params[:subject_id]
				@conditions = ['subject_id = ?',params[:subject_id]]
			when params[:author_id]
				@conditions = ['author_id = ?',params[:author_id]]
			when params[:param]				
				if !params[:book][:name].blank?
					@conditions = ['author_id LIKE ?',Author.where("name LIKE ? OR surname LIKE 				?", "%" + params[:book][:name] + "%", "%" + 	
					params[:book][:name] + "%").all[0].id] if params[:param] == 'author'
					#elsif params[:param] == "name"
					@conditions = ['name LIKE ?',
						"%" + params[:book][:name] + "%"] if params[:param] == 'name'
					#else
					@conditions = ['subject_id LIKE ?',Subject.where("name LIKE ?", 
					"%" + params[:book][:name] + "%").all[0].id] if params[:param] == 'subject'
				end
		end		
		#@books = Book.all(:conditions => @conditions)	
		
			if @conditions[1].nil? && @conditions != ['1=1']
				#@conditions = ['1=1']
				@books = []			
			
			end
		
		@books = Book.paginate :page => params[:page],:per_page => 15, :conditions => 	
			@conditions, :order => 'name'
			
	end
	
	def show
		@book = Book.find(params[:id])
	end
	
	def new	
		@book = ''
		case
			when params[:subject_id]
				@book = Book.new(:subject_id => params[:subject_id])				
			when params[:author_id]
				@book = Book.new(:author_id => params[:author_id])					
		end				
		
		@subjects = Subject.sorted		
		@authors = Author.sorted
	end
	
	def create
		#Instantiate a new object using form parameters
		@book = Book.new(params[:book])
		if @book.save
			#If save succeds
			flash[:notice] = 'Book created.'
			redirect_to(:action => 'list',:subject_id => @book.subject_id)
		else
			flash[:notice] = 'The book could not be created,try again.'
			render('new')
		end
		
	end
	
	def edit
		@book = Book.find(params[:book_id])		
			
		@subjects = Subject.sorted("name ASC")
		@author =  Author.find(@book.author_id)
		@authors = Author.sorted("surname ASC,name ASC")
	end
	
	def update
		#Find book using form parameters
		@book = Book.find(params[:book_id])
		#update the book
		if @book.update_attributes(params[:book])
			#If update succeds redirect to books(on current subject)list
			flash[:notice] = 'Book updated'
			redirect_to(:action => 'list', :subject_id => @book.subject_id)
		else
			#If save fails,redisplay the form so user can fix the problem
			render('edit')
		end
		
	end
	
	def delete
		@book = Book.find(params[:id])
	end
	
	def destroy
		#Find book to delete
		@book = Book.find(params[:id])
		@book.destroy			
		flash[:notice] = 'Book deleted.'
		redirect_to(:action => 'list', :subject_id => @subject.id)
	end
	
	
	private
	
	def find_subject		
		if params[:subject_id]
			@subject = Subject.find(params[:subject_id])			 
		end
	end
	
end
