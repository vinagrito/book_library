class BookLoansController < ApplicationController
  
	def index
		show
		render('show')
	end
	
	def show
		conditions = ['1=1']
		#conditions = ["user_id > ?",1]
		case
			when params[:user_id] 
				@user = User.find(params[:user_id])				
			when params[:user][:card_code]
				@user = User.find_by_card_code(params[:user][:card_code])		
				
		end
		conditions = ['user_id =?',@user.id]
		#@loans = BookLoan.all(:conditions => conditions)			
		
		@loans = BookLoan.paginate :page => params[:page],:per_page => 10, :conditions => conditions, :order => 'book_away'
		
	end
  	
  	def new
  		@loan = BookLoan.new
  		
  	end
  	
  		
  	def create 
  		@book = Book.find_by_code(params[:book][:code])
  		@user = User.find(params[:user_id])
  		
  		#redirect_to(:action =>'show',:user_id => @user.id)
  		
  		
  		if !@book.blank? && !@user.blank? 
	  		check_params = {:book_id => @book.id,:user_id => @user.id}
		  	#Checking for such a loan
  			@loan = BookLoan.where(check_params)
  		end
  		
  		if @loan.blank?	  		
	  		if !@book.blank? && !@user.blank?  			
  				
	  			BookLoan.create(:book_id => @book.id,:user_id => @user.id,
	  			:book_away => Time.now.to_s(:long))
	  			flash[:notice] = 'The book has been delivered.'
	  			redirect_to(:action => 'show',:user_id => @user.id)
	  		else
	  			flash[:notice] = 'User or book information are incorrect.'
	  			render('show')
	  		end
  		else
  			flash[:notice] = 'The student already has such a book.'
  			redirect_to(:action => 'show',:user_id => @user.id)
  		end
  	end

	def delivery_reminder
		conditions = ["user_id = ?",params[:user_id]]
		@user = User.find(params[:user_id])
		@loans = BookLoan.all(:conditions => conditions)
		Notifier.email_student(@user,@loans).deliver
		flash[:notice]='Email successfully sent!.'
		redirect_to(:action => 'show',:user_id => @user.id )
	end
end
