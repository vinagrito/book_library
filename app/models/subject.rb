class Subject < ActiveRecord::Base
	
	has_many :books
	
	validates :name,:presence => true, :length => { :maximum => 30}
	
	
	scope :sorted ,order('subjects.name ASC')
	scope :full_subject, lambda {|id| where(:id => id)}
	
end
