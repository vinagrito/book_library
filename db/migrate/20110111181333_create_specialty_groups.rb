class CreateSpecialtyGroups < ActiveRecord::Migration
  def self.up
    create_table :specialty_groups do |t|
		t.references 'specialty'
		t.integer 'group'      	
    end
  end

  def self.down
    drop_table :specialty_groups
  end
end
