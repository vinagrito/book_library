class Role < ActiveRecord::Base
	
	has_many :users
	
	scope :sorted,where('roles.name ASC')
end
