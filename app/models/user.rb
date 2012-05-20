require 'digest/sha1'
class User < ActiveRecord::Base
	
	belongs_to :role
	#belongs_to :department
	#belongs_to :faculty
	#belongs_to :specialty
	belongs_to :specialty_group
	has_many :book_loans
	has_many :books, :through => :book_loans
	
	
	attr_accessor :password,:password_confirmation,:new_password
	
	
	
	EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
	
	validates :name, :presence => true, :length => {:maximum => 20}
	validates :surname, :presence => true, :length => {:maximum => 20}
	validates :username, :presence => true, :length => {:maximum => 25}
	validates :role_id, :presence => true	
	
	validates_length_of :password, :within => 8..15, :on => :create
	
	with_options :if => Proc.new{ self.role_id == 3 } do |user|
		user.validates_presence_of :faculty_id,:department_id,:specialty_id,:specialty_group_id,:current_year,:card_code
	end
	validates :email, :format => EMAIL_REGEX, :confirmation => true, :presence => true, :if => Proc.new{ self.role_id == 1  || self.role_id == 3 } 
	
	
	before_save :create_hashed_password
	after_save :clear_password	
	
	scope :sorted, order('users.surname ASC')	
		
	
	attr_protected :hashed_password,:salt		
	
	
	def self.authenticate(username = '' , password = '',role_id = '')
		user = User.find_by_username(username)
		if user && user.password_match?(password) 
			return user if role_id.to_s == user.role_id.to_s
		else
			return false
		end
	end
	
	def password_match?(password = "")
		hashed_password == User.hash_with_salt(password,salt) 
	end
	
	def self.make_salt(username = "")
		Digest::SHA1.hexdigest("Put #{username} and #{Time.now} to make salt")
	end
	
	def self.hash_with_salt( password = "", salt = "")
		Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
	end	
		
	private
	
	def create_hashed_password
		unless password.blank?
			self.salt = User.make_salt(username) if salt.blank?
			self.hashed_password = User.hash_with_salt(password,salt)
		end	
	end
	
	def clear_password
		self.password = nil
		#self.new_password = nil
	end		
	
end
