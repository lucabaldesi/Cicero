require 'record_authenticate'
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

class User < ActiveRecord::Base
	validates(:shadow, presence:true, length: { minimum: 1})
	validates(:name, presence:true, length: { minimum: 4, maximum: 255}, uniqueness: { case_sensitive: false})
	has_many :speech
	credentials :name, :shadow
end
