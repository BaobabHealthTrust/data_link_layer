# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :check_login, :except => [:error]
  
  def error 
    render :json => {"authenticated" => "false"}.to_json
  end
  
protected
  
  def check_login        
    
    authenticate and return if cookies["JSESSIONID"].nil?

    authenticate and return if !File.exists?("#{Rails.root}/tmp/sessions/#{request.remote_ip.gsub(/\./, '_')}")
    
    f = File.open("#{Rails.root}/tmp/sessions/#{request.remote_ip.gsub(/\./, '_')}", "r")
    
    session_id = f.read
    
    f.close
      
    authenticate and return if cookies["JSESSIONID"].to_s.downcase.strip != session_id.to_s.downcase.strip     
    
    return true
    
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      # you probably want to guard against a wrong username, and encrypt the
      # password but this is the idea.
      result = User.authenticated?(username, password)            
      
      error and return if !result
      
      cookies["iJSESSIONID"] = Digest::SHA1.hexdigest(Time.now.to_i.to_s)
      
      f = File.open("#{Rails.root}/tmp/sessions/#{request.remote_ip.gsub(/\./, '_')}", "w+")
      
      f.write(cookies["iJSESSIONID"])
      
      f.close
      
      return true
    end
  end
  
end
