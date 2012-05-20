class SpecialtyGroup < ActiveRecord::Base
	
	belongs_to :specialty
	#belongs_to :faculty
	has_many :users
end
