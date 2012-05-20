class Department < ActiveRecord::Base
	
	belongs_to :faculty
	has_many :specialties
	#has_many :users
	
	
	validates :name, :presence => true, :length => {:maximum => 70}
	
	scope :sorted,:order => ("departments.name ASC")
end
