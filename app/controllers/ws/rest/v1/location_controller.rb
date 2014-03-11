module Ws
  module Rest
    module V1
      class LocationController < ApplicationController

        def index
          results = []
          
          locations = Location.find(:all, :limit => 50) rescue []
          
          locations.each do |location|
            result = {
                "resourceVersion"=>"1.9", 
                "childLocations"=>[], 
                "latitude"=>nil, 
                "country"=>nil, 
                "display"=>"#{location.name rescue nil}", 
                "parentLocation"=>{
                    "display"=>"#{location.parent.name rescue nil}", 
                    "links"=>[
                        {
                            "rel"=>"self", 
                            "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{location.parent.uuid rescue ""}"
                        }
                    ], 
                    "uuid"=>"#{location.parent.uuid rescue ""}"
                }, 
                "name"=>"#{location.name rescue nil}", 
                "links"=>[
                    {
                        "rel"=>"self", 
                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{location.uuid rescue ""}"
                    }, 
                    {
                        "rel"=>"full", 
                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{location.uuid rescue ""}?v=full"
                    }
                ], 
                "stateProvince"=>nil, 
                "longitude"=>nil, 
                "address6"=>nil, 
                "address5"=>nil, 
                "address4"=>nil, 
                "address3"=>nil, 
                "address2"=>nil, 
                "address1"=>nil, 
                "cityVillage"=>nil, 
                "uuid"=>"#{location.uuid rescue ""}", 
                "retired"=>false, 
                "postalCode"=>nil, 
                "description"=>nil, 
                "attributes"=>[], 
                "countyDistrict"=>nil
            }
            
            results << result
          end
          
          render :json => results.to_json

        end

        def show
          result = {}
          
          location = Location.find(params[:id]) rescue {}
          
          if !location.blank?
            result = {
                "resourceVersion"=>"1.9", 
                "childLocations"=>[], 
                "latitude"=>nil, 
                "country"=>nil, 
                "display"=>"#{location.name rescue nil}", 
                "parentLocation"=>{
                    "display"=>"#{location.parent.name rescue nil}", 
                    "links"=>[
                        {
                            "rel"=>"self", 
                            "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{location.parent.uuid rescue ""}"
                        }
                    ], 
                    "uuid"=>"#{location.parent.uuid rescue ""}"
                }, 
                "name"=>"#{location.name rescue nil}", 
                "links"=>[
                    {
                        "rel"=>"self", 
                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{location.uuid rescue ""}"
                    }, 
                    {
                        "rel"=>"full", 
                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{location.uuid rescue ""}?v=full"
                    }
                ], 
                "stateProvince"=>nil, 
                "longitude"=>nil, 
                "address6"=>nil, 
                "address5"=>nil, 
                "address4"=>nil, 
                "address3"=>nil, 
                "address2"=>nil, 
                "address1"=>nil, 
                "cityVillage"=>nil, 
                "uuid"=>"#{location.uuid rescue ""}", 
                "retired"=>false, 
                "postalCode"=>nil, 
                "description"=>nil, 
                "attributes"=>[], 
                "countyDistrict"=>nil
            }
          end
          
          render :json => result.to_json

        end

        def create
          # raise "in post"
        end
        
        def destroy
          # raise "in delete"
        end

      end
    end
  end
end
