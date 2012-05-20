class Book < ActiveRecord::Base
	
	belongs_to :subject
	belongs_to :author
		
	has_many :book_loans    
	
	validates :name, :presence => true, :length => {:maximum => 35}
	validates :author_id, :presence => true
	validates :code, :presence => true, :length => {:maximum => 13}


	scope :sorted, order("books.name ASC")	
	scope :by_subject_id, lambda{|subject_id| where(:subject_id => subject_id)}
	
	#scope :author, lambda{|subject_id| where(:subject_id => subject_id)}
	
	
end
