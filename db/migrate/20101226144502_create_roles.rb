class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      	t.string "name"  
    end
    
    execute "INSERT INTO roles (name) VALUES ('Administrator')"
    execute "INSERT INTO roles (name) VALUES ('Worker')"
    execute "INSERT INTO roles (name) VALUES ('Student')"
  end

  def self.down
    drop_table :roles
  end
end
