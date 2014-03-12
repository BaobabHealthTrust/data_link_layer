module Ws
    module Rest
        module V1
            class EncounterController < ApplicationController

                def index                    
          
                    results = {"results" => []}

                    patient = nil
                    startdate = nil
                    enddate = nil
                    types = nil

                    patient = Person.find(params[:patient]).person_id.to_s if !params[:patient].blank?
                    
                    startdate = params[:startdate] if !params[:startdate].blank?
                    
                    enddate = params[:enddate] if !params[:enddate].blank?

                    types = params[:encountertypes].split(" ").collect{|t|
                        EncounterType.find_by_name(t.strip).encounter_type_id rescue nil
                    }.compact.uniq if !params[:encountertypes].blank?

                    encounters = Encounter.find(:all, :limit => 50, 
                        :conditions => ["#{(!patient.nil? ? "patient_id = '" + patient + "' " : "")}" + 
                                "#{(!startdate.blank? ? (!patient.nil? ? " AND " : "") + " DATE(encounter_datetime) >= DATE('" + startdate + "')" : "")} " + "#{(!enddate.blank? ? ((!patient.nil? or !startdate.nil?) ? " AND " : "") + " DATE(encounter_datetime) <= DATE('" + enddate + "')" : "")} " + "#{(!types.blank? ? ((!patient.nil? or !startdate.nil? or !startdate.nil?) ? " AND " : "") + " encounter_type IN (" + types.join(", ") + ")" : "")}"]) rescue []

                    encounters.each do |encounter|
                        result = {
                            "obs"=>[], 
                            "patient"=>{
                                "uuid"=>"#{encounter.patient.person.uuid rescue nil}", 
                                "display"=>"#{encounter.patient.identifiers.first.identifier rescue nil} - #{encounter.patient.person.name rescue nil}", 
                                "links"=>[
                                    {
                                        "rel"=>"self", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/patient/#{encounter.patient.person.uuid rescue nil}"
                                    }
                                ]
                            }, 
                            "encounterDatetime"=>"#{encounter.encounter_datetime.to_date.strftime("%Y-%m-%d %H:%M") rescue nil}", 
                            "provider"=>{
                                "preferredAddress"=>nil, 
                                "birthdateEstimated"=>"#{encounter.provider.birthdate_estimated rescue nil}", 
                                "causeOfDeath"=>nil, 
                                "dead"=>false, 
                                "voided"=>false, 
                                "attributes"=>[], 
                                "uuid"=>"#{encounter.provider.uuid rescue nil}", 
                                "preferredName"=>{
                                    "uuid"=>"#{encounter.provider.names.first.uuid rescue nil}", 
                                    "display"=>"#{encounter.provider.name rescue nil}", 
                                    "links"=>[
                                        {
                                            "rel"=>"self", 
                                            "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{encounter.provider.uuid rescue nil}/name/#{encounter.provider.names.first.uuid rescue nil}"
                                        }
                                    ]
                                }, 
                                "display"=>"#{encounter.provider.name rescue nil}", 
                                "deathDate"=>nil, 
                                "gender"=>"#{encounter.provider.gender rescue nil}", 
                                "birthdate"=>"#{encounter.provider.birthdate.strftime("%Y-%m-%d") rescue nil}", 
                                "age"=>(((Date.today - encounter.provider.birthdate.to_date).to_i / 365) rescue nil), 
                                "resourceVersion"=>"1.8", 
                                "links"=>[
                                    {
                                        "rel"=>"self", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{encounter.provider.uuid rescue nil}"
                                    }, 
                                    {
                                        "rel"=>"full", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{encounter.provider.uuid rescue nil}?v=full"
                                    }
                                ]
                            }, 
                            "visit"=>nil, 
                            "voided"=>false, 
                            "uuid"=>"#{encounter.uuid rescue nil}", 
                            "display"=>"#{encounter.encountertype.name rescue nil} #{encounter.encounter_datetime.to_date.strftime("%d/%m/%Y") rescue nil}", 
                            "auditInfo"=>{}, 
                            "encounterType"=>{
                                "description"=>"#{encounter.encountertype.description rescue nil}", 
                                "name"=>"#{encounter.encountertype.name rescue nil}", 
                                "retired"=>"#{encounter.encountertype.retired rescue nil}", 
                                "uuid"=>"#{encounter.encountertype.uuid rescue nil}", 
                                "display"=>"#{encounter.encountertype.name rescue nil}", 
                                "resourceVersion"=>"1.8",
                                "links"=>[
                                    {
                                        "rel"=>"self", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/encountertype/#{encounter.encountertype.uuid rescue nil}"
                                    }, 
                                    {
                                        "rel"=>"full", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/encountertype/#{encounter.encountertype.uuid rescue nil}?v=full"
                                    }
                                ]
                            }, 
                            "location"=>{
                                "description"=>nil, 
                                "postalCode"=>"", 
                                "longitude"=>nil, 
                                "latitude"=>nil, 
                                "name"=>"#{encounter.location.name rescue nil}", 
                                "attributes"=>[], 
                                "retired"=>false, 
                                "parentLocation"=>nil, 
                                "uuid"=>"#{encounter.location.uuid rescue nil}", 
                                "tags"=>[], 
                                "cityVillage"=>"", 
                                "countyDistrict"=>nil, 
                                "stateProvince"=>"", 
                                "display"=>"#{encounter.location.name rescue nil}", 
                                "childLocations"=>[], 
                                "country"=>"", 
                                "resourceVersion"=>"1.9", 
                                "links"=>[
                                    {
                                        "rel"=>"self", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{encounter.location.uuid rescue nil}"
                                    }, 
                                    {
                                        "rel"=>"full", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{encounter.location.uuid rescue nil}?v=full"
                                    }
                                ], 
                                "address6"=>nil, 
                                "address5"=>nil, 
                                "address4"=>nil, 
                                "address3"=>nil, 
                                "address2"=>"", 
                                "address1"=>""
                            }, 
                            "resourceVersion"=>"1.9", 
                            "links"=>[
                                {
                                    "rel"=>"self", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/encounter/#{encounter.uuid rescue nil}"
                                }
                            ], 
                            "orders"=>[], 
                            "form"=>nil
                        }
                        
                        encounter.obs.each do |obs|
                            result["obs"] << {
                                "comment"=>nil, 
                                "groupMembers"=>nil, 
                                "value"=>"#{obs.value rescue nil}", 
                                "valueCodedName"=>nil, 
                                "valueModifier"=>nil, 
                                "voided"=>"#{obs.voided rescue nil}", 
                                "encounter"=>{
                                    "uuid"=>"#{encounter.uuid rescue nil}", 
                                    "display"=>"#{encounter.type rescue nil} #{encounter.encounter_datetime.to_date.strftime("%d/%m/%Y") rescue nil}", 
                                    "links"=>[
                                        {
                                            "rel"=>"self", 
                                            "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/encounter/#{encounter.uuid rescue nil}"
                                        }
                                    ]
                                }, 
                                "person"=>{
                                    "uuid"=>"#{encounter.patient.person.uuid rescue nil}", 
                                    "display"=>"#{encounter.patient.identifiers.first.identifier rescue nil} - #{encounter.patient.person.name rescue nil}", 
                                    "links"=>[
                                        {
                                            "rel"=>"self", 
                                            "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/patient/#{encounter.patient.person.uuid rescue nil}"
                                        }
                                    ]
                                }, 
                                "uuid"=>"#{obs.uuid rescue nil}", 
                                "obsGroup"=>nil, 
                                "accessionNumber"=>nil, 
                                "display"=>"#{obs.concept.name rescue nil}: #{obs.value rescue nil}", 
                                "location"=>{
                                    "uuid"=>"#{obs.location.uuid rescue nil}", 
                                    "display"=>"#{obs.location.name rescue nil}", 
                                    "links"=>[
                                        {
                                            "rel"=>"self", 
                                            "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{obs.location.uuid rescue nil}"
                                        }
                                    ]
                                }, 
                                "obsDatetime"=>"#{obs.obs_datetime.to_date.strftime("%Y-%m-%d %H:%M") rescue nil}", 
                                "resourceVersion"=>"1.8", 
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
                                "order"=>nil, 
                                "concept"=>{
                                    "uuid"=>"#{obs.concept.uuid rescue nil}", 
                                    "display"=>"#{obs.concept.name rescue nil}", 
                                    "links"=>[
                                        {
                                            "rel"=>"self", 
                                            "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/concept/#{obs.concept.uuid rescue nil}"
                                        }
                                    ]
                                }
                            }                        
                        end
                        
                        results["results"] << result 
                    
                    end
                    
                    render :json => results.to_json

                end

                def show
          
                    result = {}
          
                    encounter = Encounter.find(params[:id]) rescue {}
          
                    if !encounter.blank?

                    result = {
                        "obs"=>[], 
                        "patient"=>{
                            "uuid"=>"#{encounter.patient.person.uuid rescue nil}", 
                            "display"=>"#{encounter.patient.identifiers.first.identifier rescue nil} - #{encounter.patient.person.name rescue nil}", 
                            "links"=>[
                                {
                                    "rel"=>"self", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/patient/#{encounter.patient.person.uuid rescue nil}"
                                }
                            ]
                        }, 
                        "encounterDatetime"=>"#{encounter.encounter_datetime.to_date.strftime("%Y-%m-%d %H:%M") rescue nil}", 
                        "provider"=>{
                            "preferredAddress"=>nil, 
                            "birthdateEstimated"=>"#{encounter.provider.birthdate_estimated rescue nil}", 
                            "causeOfDeath"=>nil, 
                            "dead"=>false, 
                            "voided"=>false, 
                            "attributes"=>[], 
                            "uuid"=>"#{encounter.provider.uuid rescue nil}", 
                            "preferredName"=>{
                                "uuid"=>"#{encounter.provider.names.first.uuid rescue nil}", 
                                "display"=>"#{encounter.provider.name rescue nil}", 
                                "links"=>[
                                    {
                                        "rel"=>"self", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{encounter.provider.uuid rescue nil}/name/#{encounter.provider.names.first.uuid rescue nil}"
                                    }
                                ]
                            }, 
                            "display"=>"#{encounter.provider.name rescue nil}", 
                            "deathDate"=>nil, 
                            "gender"=>"#{encounter.provider.gender rescue nil}", 
                            "birthdate"=>"#{encounter.provider.birthdate.strftime("%Y-%m-%d") rescue nil}", 
                            "age"=>(((Date.today - encounter.provider.birthdate.to_date).to_i / 365) rescue nil), 
                            "resourceVersion"=>"1.8", 
                            "links"=>[
                                {
                                    "rel"=>"self", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{encounter.provider.uuid rescue nil}"
                                }, 
                                {
                                    "rel"=>"full", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{encounter.provider.uuid rescue nil}?v=full"
                                }
                            ]
                        }, 
                        "visit"=>nil, 
                        "voided"=>false, 
                        "uuid"=>"#{encounter.uuid rescue nil}", 
                        "display"=>"#{encounter.encountertype.name rescue nil} #{encounter.encounter_datetime.to_date.strftime("%d/%m/%Y") rescue nil}", 
                        "auditInfo"=>{}, 
                        "encounterType"=>{
                            "description"=>"#{encounter.encountertype.description rescue nil}", 
                            "name"=>"#{encounter.encountertype.name rescue nil}", 
                            "retired"=>"#{encounter.encountertype.retired rescue nil}", 
                            "uuid"=>"#{encounter.encountertype.uuid rescue nil}", 
                            "display"=>"#{encounter.encountertype.name rescue nil}", 
                            "resourceVersion"=>"1.8",
                            "links"=>[
                                {
                                    "rel"=>"self", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/encountertype/#{encounter.encountertype.uuid rescue nil}"
                                }, 
                                {
                                    "rel"=>"full", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/encountertype/#{encounter.encountertype.uuid rescue nil}?v=full"
                                }
                            ]
                        }, 
                        "location"=>{
                            "description"=>nil, 
                            "postalCode"=>"", 
                            "longitude"=>nil, 
                            "latitude"=>nil, 
                            "name"=>"#{encounter.location.name rescue nil}", 
                            "attributes"=>[], 
                            "retired"=>false, 
                            "parentLocation"=>nil, 
                            "uuid"=>"#{encounter.location.uuid rescue nil}", 
                            "tags"=>[], 
                            "cityVillage"=>"", 
                            "countyDistrict"=>nil, 
                            "stateProvince"=>"", 
                            "display"=>"#{encounter.location.name rescue nil}", 
                            "childLocations"=>[], 
                            "country"=>"", 
                            "resourceVersion"=>"1.9", 
                            "links"=>[
                                {
                                    "rel"=>"self", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{encounter.location.uuid rescue nil}"
                                }, 
                                {
                                    "rel"=>"full", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{encounter.location.uuid rescue nil}?v=full"
                                }
                            ], 
                            "address6"=>nil, 
                            "address5"=>nil, 
                            "address4"=>nil, 
                            "address3"=>nil, 
                            "address2"=>"", 
                            "address1"=>""
                        }, 
                        "resourceVersion"=>"1.9", 
                        "links"=>[
                            {
                                "rel"=>"self", 
                                "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/encounter/#{encounter.uuid rescue nil}"
                            }
                        ], 
                        "orders"=>[], 
                        "form"=>nil
                    }

                    encounter.obs.each do |obs|
                        result["obs"] << {
                            "comment"=>nil, 
                            "groupMembers"=>nil, 
                            "value"=>"#{obs.value rescue nil}", 
                            "valueCodedName"=>nil, 
                            "valueModifier"=>nil, 
                            "voided"=>"#{obs.voided rescue nil}", 
                            "encounter"=>{
                                "uuid"=>"#{encounter.uuid rescue nil}", 
                                "display"=>"#{encounter.type rescue nil} #{encounter.encounter_datetime.to_date.strftime("%d/%m/%Y") rescue nil}", 
                                "links"=>[
                                    {
                                        "rel"=>"self", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/encounter/#{encounter.uuid rescue nil}"
                                    }
                                ]
                            }, 
                            "person"=>{
                                "uuid"=>"#{encounter.patient.person.uuid rescue nil}", 
                                "display"=>"#{encounter.patient.identifiers.first.identifier rescue nil} - #{encounter.patient.person.name rescue nil}", 
                                "links"=>[
                                    {
                                        "rel"=>"self", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/patient/#{encounter.patient.person.uuid rescue nil}"
                                    }
                                ]
                            }, 
                            "uuid"=>"#{obs.uuid rescue nil}", 
                            "obsGroup"=>nil, 
                            "accessionNumber"=>nil, 
                            "display"=>"#{obs.concept.name rescue nil}: #{obs.value rescue nil}", 
                            "location"=>{
                                "uuid"=>"#{obs.location.uuid rescue nil}", 
                                "display"=>"#{obs.location.name rescue nil}", 
                                "links"=>[
                                    {
                                        "rel"=>"self", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{obs.location.uuid rescue nil}"
                                    }
                                ]
                            }, 
                            "obsDatetime"=>"#{obs.obs_datetime.to_date.strftime("%Y-%m-%d %H:%M") rescue nil}", 
                            "resourceVersion"=>"1.8", 
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
                            "order"=>nil, 
                            "concept"=>{
                                "uuid"=>"#{obs.concept.uuid rescue nil}", 
                                "display"=>"#{obs.concept.name rescue nil}", 
                                "links"=>[
                                    {
                                        "rel"=>"self", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/concept/#{obs.concept.uuid rescue nil}"
                                    }
                                ]
                            }
                        }
                    end
                end
          
                render :json => result.to_json

                end

                def create
                  # {"patient":"71afcea7-8e53-4603-a8ea-e87d74d4f71b","encounterDatetime":"2014-03-11","location":"Unknown Location","encounterType":"Vitals","provider":"dcb91ea8-2e80-11e3-9083-1328915d1f84","obs":[{"concept":"5088AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","value":"36.7"},{"concept":"5087AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","value":"30"},{"concept":"5085AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","value":"120"},{"concept":"5086AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","value":"80"},{"concept":"5242AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","value":"10"},{"concept":"5089AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","value":"96.0"},{"concept":"5090AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","value":"169"},{"concept":"5092AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","value":"12"}]}  
                  
                  fields = [
                      "5088AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 
                      "5087AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 
                      "5085AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 
                      "5086AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 
                      "5242AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 
                      "5089AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 
                      "5090AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 
                      "5092AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
                    ]        
                     
                    type = EncounterType.find_by_name(params[:encounterType]).encounter_type_id # rescue nil
                    
                    patient = Person.find(params[:patient]).person_id # rescue nil
                    
                    provider = User.find_by_person_id(Person.find(params[:provider]).person_id).user_id # rescue nil
                    
                    location = Location.find_by_name(params[:location]).location_id # rescue nil
                    
                    if !type.nil? and !patient.nil?
                    
                        guuid = Encounter.guuid
                        
                        if Encounter.column_names.include?("provider_id")
                            encounter = Encounter.create(
                                    :patient_id => patient,
                                    :encounter_type => type, 
                                    :encounter_datetime => ((!params["encounterDatetime"].nil? ? params["encounterDatetime"].to_time : Time.now).strftime("%Y-%m-%d %H:%M")),
                                    :creator => provider,
                                    :provider_id => provider,
                                    :location_id => location,
                                    :date_created => Time.now,
                                    :uuid => "#{guuid.to_s}"
                                ) # rescue nil 
                        else
                            encounter = Encounter.create(
                                    :patient_id => patient,
                                    :encounter_type => type, 
                                    :encounter_datetime => ((!params["encounterDatetime"].nil? ? params["encounterDatetime"].to_time : Time.now).strftime("%Y-%m-%d %H:%M")),
                                    :creator => provider,
                                    :location_id => location,
                                    :date_created => Time.now,
                                    :uuid => "#{guuid.to_s}"
                                ) # rescue nil
                        end
                            
                  # {"5242AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"=>"10", "authenticity_token"=>"3td5LO14shKgi/gNg9nDcfaBwEhjxUcH2PODwQAA4ro=", "encounter_type"=>"Vitals", "5090AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"=>"169", "5088AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"=>"36.7", "5087AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"=>"30", "5092AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"=>"12", "5089AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"=>"96.0", "5085AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"=>"120", "5086AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"=>"80"}
                  
                        encounter_id = encounter.encounter_id
                  
                        if !encounter_id.blank?
                            params[:obs].each do |field|
                                
                                concept = Concept.find(field[:concept]).concept_id # rescue nil
                            
                                Obs.create(
                                    :person_id => patient,
                                    :concept_id => concept,
                                    :encounter_id => encounter_id,
                                    :obs_datetime => (!params[:encounterDatetime].nil? ? params[:encounterDatetime] : Time.now.strftime("%Y-%m-%d %H:%M")),
                                    :location_id => location,
                                    (field[:value].strip.match(/^\d+(\.\d+)?/) ? :value_numeric : :value_text) => field[:value],
                                    :creator => provider,
                                    :date_created => Time.now,
                                    :uuid => "#{Encounter.guuid}"
                                )
                            end
                        else
                        
                            render :json => {"save" => "error", "encounter" => encounter_id.to_s}.to_json and return
                        
                        end
                    
                        render :json => {"save" => "success"}.to_json and return
                    else
                        render :json => {"save" => "error", "patient" => patient.to_s, "type" => type.to_s}.to_json and return
                    end
                     
                end
                
                def destroy
                  # raise "in delete"
                end

            end
        end
    end
end
