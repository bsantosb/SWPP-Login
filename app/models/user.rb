class User < ActiveRecord::Base

	validates_uniqueness_of :username
	validates :username, presence: true, length: { minimum: 5 , maximum:20 }
	validates :password, length: {minimum:8, maximum:20} 	
	
end
