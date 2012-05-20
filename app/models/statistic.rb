class Statistic < ActiveRecord::Base
		
	belongs_to :specialty
	has_many :apriori_combinations
end
