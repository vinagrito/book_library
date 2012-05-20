class CreateFaculties < ActiveRecord::Migration
  def self.up
    create_table :faculties do |t|
		
    	t.string "name",:null => false	    	
    end
    add_index :faculties,["name"]  
  end

  def self.down
    drop_table :faculties
  end
end
