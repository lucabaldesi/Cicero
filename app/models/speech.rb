class Speech < ActiveRecord::Base
	belongs_to :user
	validates(:name, presence:true, uniqueness: true)
	validates(:grammar, presence:true)

	def to_param
		self.name
	end

	def to_s
		self.name
	end

end
