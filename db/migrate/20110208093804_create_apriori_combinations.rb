class CreateAprioriCombinations < ActiveRecord::Migration
  def self.up
    create_table :apriori_combinations do |t|
		t.references :statistic
  		t.string :combination
  		t.integer :support
    end
  end

  def self.down
    drop_table :apriori_combinations
  end
end
