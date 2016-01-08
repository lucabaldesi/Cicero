require 'digest/md5'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate
	authenticate_with_http_basic do |user,pass|
		  @current_user = User.authenticate user, pass
	end
	unless (@current_user)
		redirect_to '/signin' 
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
