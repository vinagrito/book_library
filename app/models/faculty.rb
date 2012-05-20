class Faculty < ActiveRecord::Base
	
	has_many :departments
	#has_many :users,:through => :departments
	#has_many :specialties, :through => :departments
	#has_many :specialty_groups, :through => :specialties
	
	validates :name, :presence => true, :length => {:maximum => 70}
	
	scope :sorted,:order => ("faculties.name ASC")
end
