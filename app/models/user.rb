VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

class User < ActiveRecord::Base
	validates(:shadow, presence:true, length: { minimum: 1})
	validates(:mail, presence:true, length: { minimum: 4, maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false})
	has_many :speech
end
