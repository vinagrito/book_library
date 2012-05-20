class CreateUsers < ActiveRecord::Migration
  def self.up   
    create_table :users do |t|    	
         	t.references "faculty"
        	t.references "department"
        	t.references "specialty"
    		t.references "role", :null => false
    		t.references "specialty_group"
         	t.string "name", :null => false, :limit => 20
    		t.string "surname", :null => false, :limit => 20
         	t.string "username",:null => false, :limit => 25     		    		
     		t.integer "current_year"
     		t.string "card_code"
         	t.boolean "day_time", :default => false
         	t.string "email", :limit => 100	
         	t.string "hashed_password", :limit => 40         	
         	t.string "salt", :limit => 40
    		t.boolean "active", :default => false
         	t.timestamps
    end    	
        add_index :users,["faculty_id","department_id","username"]
        add_index :users,["specialty_id","specialty_group_id"] 
  end

  def self.down
    drop_table :users
  end
end
