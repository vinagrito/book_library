class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
		t.string "name"
		t.string "surname"
		t.string "country"    
    end
    add_index :authors,["surname"]  
      
  end

  def self.down
    drop_table :authors
  end
end
