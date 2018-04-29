class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_hostname_and_port
  before_filter :get_browser_details


  def get_hostname_and_port
  	@host = request.host
  	@port = request.port
  end

  def get_browser_details
  	user_agent = UserAgent.parse(request.env['HTTP_USER_AGENT'])
  	@browser = user_agent.browser
  	@version = user_agent.version
  end

end
