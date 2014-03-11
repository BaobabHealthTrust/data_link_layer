module Ws
  module Rest
    module V1
      class SessionController < ActionController::Base  
        before_filter :authenticate, :except => [:delete]
        
        def index
          render :json => {
            "authenticated" => "TRUE", 
            "sessionId" => cookies["iJSESSIONID"]
          }.to_json
        end

        def create
          render :json => {}.to_json
        end
        
        def destroy
          cookies.delete "iJSESSIONID"
          
          File.delete("#{Rails.root}/tmp/sessions/#{request.remote_ip.gsub(/\./, '_')}") if File.exists?("#{Rails.root}/tmp/sessions/#{request.remote_ip.gsub(/\./, '_')}")
          
          render :json => {"logout" => "success"}.to_json
        end
        
protected

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
    end
  end
end
