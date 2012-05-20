class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
		t.references "subject"
		t.references "author"
		t.string "code",:null => false
		t.string "name",:null => false, :limit => 50		
		t.string "permalink"
		t.text "content_index"
		t.string "editorial"
		t.string "editorial_country" 
		t.float "price"   	
    end
    add_index :books,["subject_id","author_id","permalink"]      
   
  end

  def self.down
    drop_table :books
  end
end
