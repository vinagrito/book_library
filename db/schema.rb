# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110208093804) do

  create_table "apriori_combinations", :force => true do |t|
    t.integer "statistic_id"
    t.string  "combination"
    t.integer "support"
  end

  create_table "authors", :force => true do |t|
    t.string "name"
    t.string "surname"
    t.string "country"
  end

  add_index "authors", ["surname"], :name => "index_authors_on_surname"

  create_table "book_loans", :force => true do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "book_away"
    t.datetime "book_back"
  end

  add_index "book_loans", ["book_id", "user_id"], :name => "index_book_loans_on_book_id_and_user_id"

  create_table "books", :force => true do |t|
    t.integer "subject_id"
    t.integer "author_id"
    t.string  "code",                            :null => false
    t.string  "name",              :limit => 50, :null => false
    t.string  "permalink"
    t.text    "content_index"
    t.string  "editorial"
    t.string  "editorial_country"
    t.float   "price"
  end

  add_index "books", ["subject_id", "author_id", "permalink"], :name => "index_books_on_subject_id_and_author_id_and_permalink"

  create_table "departments", :force => true do |t|
    t.integer "faculty_id"
    t.string  "name",       :null => false
  end

  add_index "departments", ["name"], :name => "index_departments_on_name"

  create_table "faculties", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "faculties", ["name"], :name => "index_faculties_on_name"

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "specialties", :force => true do |t|
    t.integer "faculty_id"
    t.integer "department_id"
    t.string  "name"
  end

  create_table "specialty_groups", :force => true do |t|
    t.integer "specialty_id"
    t.integer "group"
  end

  create_table "statistics", :force => true do |t|
    t.integer  "faculty_id"
    t.integer  "department_id"
    t.integer  "specialty_id"
    t.integer  "current_year"
    t.datetime "run_at"
    t.integer  "support"
  end

  add_index "statistics", ["specialty_id"], :name => "index_statistics_on_specialty_id"

  create_table "subjects", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "faculty_id"
    t.integer  "department_id"
    t.integer  "specialty_id"
    t.integer  "role_id",                                              :null => false
    t.integer  "specialty_group_id"
    t.string   "name",               :limit => 20,                     :null => false
    t.string   "surname",            :limit => 20,                     :null => false
    t.string   "username",           :limit => 25,                     :null => false
    t.integer  "current_year"
    t.string   "card_code"
    t.boolean  "day_time",                          :default => false
    t.string   "email",              :limit => 100
    t.string   "hashed_password",    :limit => 40
    t.string   "salt",               :limit => 40
    t.boolean  "active",                            :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["faculty_id", "department_id", "username"], :name => "index_users_on_faculty_id_and_department_id_and_username"
  add_index "users", ["specialty_id", "specialty_group_id"], :name => "index_users_on_specialty_id_and_specialty_group_id"

end
