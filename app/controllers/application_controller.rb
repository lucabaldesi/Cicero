require 'digest/md5'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate
	  authenticate_or_request_with_http_basic do |user, pass|
		  @current_user = User.find_by_mail(user)
		  (@current_user) && Digest::MD5.hexdigest(pass) == @current_user.shadow
	  end
  end

  def get_user
	  @current_user
  end

  def api
  end

end
