require 'base64'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authentication_kiss
	authenticate_with_http_basic do |user,pass|
		@current_user = User.authenticate user, pass
	end

	unless (@current_user)
		@error = "Credentials required."
		realm = request.server_name
		headers["WWW-Authenticate"] = %(Basic realm="#{realm.gsub(/"/, "")}")
		render 'signin', status: 401
	end
	@current_user
  end

  def get_user
	  @current_user
  end

  def api
  end

  def signin
  end

end
