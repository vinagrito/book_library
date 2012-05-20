class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments do |t|
		t.references "faculty"
    	t.string "name",:null => false
    end
    add_index :departments,["name"]   
  end

  def self.down
    drop_table :departments
  end
end
