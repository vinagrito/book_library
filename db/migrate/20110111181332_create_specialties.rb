class CreateSpecialties < ActiveRecord::Migration
  def self.up
    create_table :specialties do |t|
		t.references 'faculty'
		t.references 'department'
		t.string :name
    end
  end

  def self.down
    drop_table :specialties
  end
end
