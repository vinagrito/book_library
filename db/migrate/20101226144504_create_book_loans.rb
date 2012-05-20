class CreateBookLoans < ActiveRecord::Migration
  def self.up
    create_table :book_loans do |t|
	t.references "book"
  	t.references "user"
    t.datetime "book_away"
  	t.datetime "book_back"
    end
    add_index :book_loans,["book_id","user_id"]   
  end

  def self.down
    drop_table :book_loans
  end
end
