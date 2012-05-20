class Specialty < ActiveRecord::Base
	
	belongs_to :department
	#belongs_to :faculty
	has_many :specialty_groups
	#has_many :users
	has_many :statistics
	
end
