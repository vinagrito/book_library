class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
    	
		t.string "name",:null => false  
    end   
	
  end

  def self.down
    drop_table :subjects
  end
end
