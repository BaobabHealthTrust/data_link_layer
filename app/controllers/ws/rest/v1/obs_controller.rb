module Ws
    module Rest
        module V1
            class ObsController < ApplicationController

            def index
                  
                results = {"results" => []}
          
                observations = Obs.find(:all, :limit => 50) rescue []

                observations.each do |obs|

                    result = {
                        "resourceVersion"=>"1.8", 
                        "groupMembers"=>nil, 
                        "accessionNumber"=>nil, 
                        "obsDatetime"=>"#{obs.obs_datetime.to_date.strftime("%Y-%m-%d %H:%M") rescue nil}", 
                        "value"=>"#{obs.value rescue ""}", 
                        "concept"=>{
                            "display"=>"#{obs.concept.name rescue nil}", 
                            "links"=>[
                                {
                                    "rel"=>"self", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/concept/#{obs.concept.uuid rescue nil}"
                                }
                            ], 
                            "uuid"=>"#{obs.concept.uuid rescue nil}"
                        }, 
                        "display"=>"#{obs.concept.name rescue nil}: #{obs.value rescue nil}", 
                        "obsGroup"=>nil, 
                        "links"=>[
                            {
                                "rel"=>"self", 
                                "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/obs/#{obs.uuid rescue nil}"
                            }, 
                            {
                                "rel"=>"full", 
                                "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/obs/#{obs.uuid rescue nil}?v=full"
                            }
                        ], 
                        "location"=>{
                            "display"=>"#{obs.location.name rescue nil}", 
                            "links"=>[
                                {
                                    "rel"=>"self", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{obs.location.uuid rescue nil}"
                                }
                            ], 
                            "uuid"=>"#{obs.location.uuid rescue nil}"
                        }, 
                        "comment"=>nil, 
                        "order"=>nil, 
                        "valueModifier"=>nil, 
                        "encounter"=>{
                            "display"=>"#{obs.encounter.type rescue ""} #{obs.encounter.encounter_datetime.to_date.strftime("%Y-%m-%d") rescue ""}", 
                            "links"=>[
                                {
                                    "rel"=>"self", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/encounter/#{obs.encounter.uuid rescue nil}"
                                }
                            ], 
                            "uuid"=>"#{obs.encounter.uuid rescue nil}"
                        }, 
                        "uuid"=>"#{obs.uuid rescue nil}", 
                        "voided"=>"#{obs.voided rescue nil}", 
                        "valueCodedName"=>nil, 
                        "person"=>{
                            "display"=>"#{obs.person.patient.identifiers.first.identifier rescue nil} - #{obs.person.name rescue nil}", 
                            "links"=>[
                                {
                                    "rel"=>"self", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/patient/#{obs.person.uuid rescue nil}"
                                }
                            ], 
                            "uuid"=>"#{obs.person.uuid rescue nil}"
                        }
                    }
              
                    results["results"] << result
              
                end
              
                render :json => results.to_json

            end

            def show
              
                result = {}
          
                obs = Obs.find(params[:id]) rescue {}

                if !obs.blank?

                result = {
                    "resourceVersion"=>"1.8", 
                    "groupMembers"=>nil, 
                    "accessionNumber"=>nil, 
                    "obsDatetime"=>"#{obs.obs_datetime.to_date.strftime("%Y-%m-%d %H:%M") rescue nil}", 
                    "value"=>"#{obs.value rescue ""}", 
                    "concept"=>{
                        "display"=>"#{obs.concept.name rescue nil}", 
                        "links"=>[
                            {
                                "rel"=>"self", 
                                "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/concept/#{obs.concept.uuid rescue nil}"
                            }
                        ], 
                        "uuid"=>"#{obs.concept.uuid rescue nil}"
                    }, 
                    "display"=>"#{obs.concept.name rescue nil}: #{obs.value rescue nil}", 
                    "obsGroup"=>nil, 
                    "links"=>[
                        {
                            "rel"=>"self", 
                            "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/obs/#{obs.uuid rescue nil}"
                        }, 
                        {
                            "rel"=>"full", 
                            "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/obs/#{obs.uuid rescue nil}?v=full"
                        }
                    ], 
                    "location"=>{
                        "display"=>"#{obs.location.name rescue nil}", 
                        "links"=>[
                            {
                                "rel"=>"self", 
                                "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{obs.location.uuid rescue nil}"
                            }
                        ], 
                        "uuid"=>"#{obs.location.uuid rescue nil}"
                    }, 
                    "comment"=>nil, 
                    "order"=>nil, 
                    "valueModifier"=>nil, 
                    "encounter"=>{
                        "display"=>"#{obs.encounter.type rescue ""} #{obs.encounter.encounter_datetime.to_date.strftime("%Y-%m-%d") rescue ""}", 
                        "links"=>[
                            {
                                "rel"=>"self", 
                                "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/encounter/#{obs.encounter.uuid rescue nil}"
                            }
                        ], 
                        "uuid"=>"#{obs.encounter.uuid rescue nil}"
                    }, 
                    "uuid"=>"#{obs.uuid rescue nil}", 
                    "voided"=>"#{obs.voided rescue nil}", 
                    "valueCodedName"=>nil, 
                    "person"=>{
                        "display"=>"#{obs.person.patient.identifiers.first.identifier rescue nil} - #{obs.person.name rescue nil}", 
                        "links"=>[
                            {
                                "rel"=>"self", 
                                "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/patient/#{obs.person.uuid rescue nil}"
                            }
                        ], 
                        "uuid"=>"#{obs.person.uuid rescue nil}"
                    }
                }
          
            end
          
            render :json => result.to_json

        end

        def create
          # raise "in post"
        end
        
        def destroy
            
          obs = Obs.find_by_uuid(params[:id]).update_attributes(
                            :voided => 1, 
                            :voided_by => 1, 
                            :date_voided => Date.today, 
                            :void_reason => "Vitals void"
                        ) # rescue nil
          
          render :json => {"void" => "success"}.to_json if !obs.nil?
          
          render :json => {"void" => "error"}.to_json if obs.nil?
        end

      end
    end
  end
end
