require_dependency 'record_authenticate'

class UsersController < ApplicationController
	before_filter :authentication_kiss, :except => [:new, :create]

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

	def myuser
		@user = get_user
		if @user
			render "show"
		end
	end
end
