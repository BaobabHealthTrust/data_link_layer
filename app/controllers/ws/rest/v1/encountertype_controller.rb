module Ws
    module Rest
        module V1
            class EncountertypeController < ApplicationController 
        
                def index
          
                    results = []
                      
                    types = EncounterType.find(:all, :conditions => ["name = ?", params[:q]]) rescue []
                    
                    types = EncounterType.find(:all, :limit => 50) rescue [] if types.blank? or params[:q].blank?
                      
                    types.each do |type|  
                      
                        result = {
                            "uuid"=>"#{type.uuid rescue nil}", 
                            "display"=>"#{type.name rescue nil}", 
                            "links"=>[
                                {
                                    "rel"=>"self", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/encountertype/#{type.uuid rescue nil}"
                                }
                            ]
                        }
        
                        results << result
                        
                    end
                    
                    render :json => results.to_json
                end

                def show
                  

                  render :json => {}.to_json
                end

                def create
                  render :json => {}.to_json
                end

                def destroy
                  render :json => {}.to_json
                end
        
            end
        end
    end
end
