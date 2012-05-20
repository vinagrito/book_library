class Author < ActiveRecord::Base
	
	has_many :books		
	
	validates :name, :presence => true, :length => {:maximum => 50}
	validates :surname, :presence => true, :length => {:maximum => 30}	
	validates :country, :presence => true, :length => {:maximum => 30}	
	
	scope :sorted,order("authors.surname ASC,authors.name ASC")
		
end
