require 'digest/md5'

class UsersController < ApplicationController
	def index
		render plain: "Not allowed"
	end

	def new

	end
	
	def create
		shadow = Digest::MD5.hexdigest(params["password"])
		email = params["email"]
		@neo = User.new({mail: email, shadow: shadow})

		if @neo.save
			redirect_to @neo
		else
			@error = "Credentials not valid"
			render "new"
		end
	end

	def show
		@user = User.find(params[:id])
	end
end
