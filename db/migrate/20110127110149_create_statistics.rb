class CreateStatistics < ActiveRecord::Migration
  def self.up
    create_table :statistics do |t|
    	t.references 'faculty'    	
        t.references 'department'
        t.references 'specialty'
        t.integer 'current_year'
        t.datetime 'run_at'
        t.integer 'support'
    end
    add_index :statistics,["specialty_id"]
  end

  def self.down
    drop_table :statistics
  end
end
