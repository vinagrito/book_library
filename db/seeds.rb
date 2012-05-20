# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#Subjects
Subject.create(:name => 'математика')
Subject.create(:name => 'программирование')
Subject.create(:name => 'физика')

#Roles
Role.create(:name => 'Administrator')
Role.create(:name => 'Worker')
Role.create(:name => 'Student')

#Faculties
Faculty.create(:name => 'ФИТР')
Faculty.create(:name => 'ФПМИ')

#Departments
Department.create(:faculty_id => 1,:name => 'САПР')
Department.create(:faculty_id => 2,:name => 'Физ-мат')

#Specialties
Specialty.create(:faculty_id => 1, :department_id => 1,:name => 'Информационные системы и технологии')
Specialty.create(:faculty_id => 2, :department_id => 2,:name => 'Математика')

#Specialty groups
SpecialtyGroup.create(:specialty_id => 1,:group => '107525' )
SpecialtyGroup.create(:specialty_id => 2,:group => '456974' )

#Authors
Author.create(:name => 'Николай',:surname => 'Микулик',:country => 'Belarus')
Author.create(:name => 'Kevin',:surname => 'Skoglund',:country => 'USA')
Author.create(:name => 'Жорес',:surname => 'Альферов',:country => 'Russia')

#Books
Book.create(:subject_id => 2, :author_id => 2, :code => 34567,:name => 'Руби на рейлсах')
Book.create(:subject_id => 1, :author_id => 1, :code => 12354321,:name => 'Высшая математика')
Book.create(:subject_id => 3, :author_id => 3, :code => 9876587,:name => 'Физика для инженеров')


#Users
User.create(:role_id =>1,:name => 'Elena',:surname => 'Shulman',:username => 'mama',:email => 'shulena@gmail.com',:password => '123456789')
User.create(:role_id =>3,:name => 'Daniel',:surname => 'Garcia',:username => 'vinagrito',:email => 'vinagrito@gmail.com',:password => '123456789',
:specialty_group_id => 2,:faculty_id => 1,:department_id => 1, :specialty_id => 1, :card_code => 456789,:day_time => true, :active => true,
:current_year => 6)
User.create(:role_id =>3,:name => 'Liev',:surname => 'Garcia',:username => 'lievcin',:email => 'lievcin@gmail.com',:password => '123456789',
:specialty_group_id => 1,:faculty_id => 2,:department_id => 2, :specialty_id => 2, :card_code => 9871023,:day_time => true, :active => true,
:current_year => 2)



























