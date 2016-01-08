require_dependency 'record_authenticate'

class UsersController < ApplicationController
	before_filter :authenticate, :except => [:new, :create]

#	def index
#		render plain: "Not implemented"
#	end

	def new

	end
	
	def create
		shadow = params["password"]
		name = params["name"]
		@neo = User.new({name: name, shadow: shadow})

		if @neo.save
			redirect_to url_for(controller: 'users', action: 'myuser') 
		else
			@error = "Credentials not valid"
			render "new"
		end
	end

#	def show
#		#@user = User.find_by_id(params[:id])
#		@user = @current_user
#	end

	def myuser
		@user = @current_user
		render "show"
	end
end
