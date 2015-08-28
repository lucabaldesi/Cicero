require 'digest/md5'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate
	  authenticate_or_request_with_http_basic do |user, pass|
		  u = User.find_by_mail(user)
		  (u) && Digest::MD5.hexdigest(pass) == u.shadow
	  end
  end

end
