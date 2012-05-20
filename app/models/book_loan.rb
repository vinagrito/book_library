class BookLoan < ActiveRecord::Base
	
	belongs_to :reader,:class_name => ("User"),:foreign_key => "user_id"
	belongs_to :book
	
end
