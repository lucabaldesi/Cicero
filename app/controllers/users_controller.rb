class UsersController < ApplicationController
	before_filter :authenticate, :except => [:new, :create]

	def index
		render plain: "Not implemented"
	end

	def new

	end
	
	def create
		shadow = Digest::MD5.hexdigest(params["password"])
		name = params["name"]
		@neo = User.new({name: name, shadow: shadow})

		if @neo.save
			redirect_to @neo
		else
			@error = "Credentials not valid"
			render "new"
		end
	end

	def show
		@user = User.find_by_id(params[:id])
	end

	def myuser
		authenticate
		@user = @current_user
		render "show"
	end
end
