require 'net/imap'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '03a0b7974c372c1c89f21acb6b720fb2'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  private
  
    def setup_imap
      @imap = Net::IMAP.new(params[:domain], 993, true)
    end
    
    def close_imap
      @imap.logout
    end
    
    def authenticate
      authenticate_or_request_with_http_basic do |user_name, password|
        response = @imap.login(user_name || params[:user], password)
        response.name == 'OK'
      end
    end
  
end
