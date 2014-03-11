module Ws
  module Rest
    module V1
      class PatientController < ApplicationController 
                
        def index
          results = {"results" => []}
          
          names = PersonName.find(:all, :limit => 50, :conditions => ["CONCAT(given_name, ' ', family_name) LIKE ?", "%#{params[:q]}%"]).uniq rescue []
          
          people = []
          
          names.each do |name|
            people << name.person if (name.person.voided rescue nil) != 1
          end
          
          people = Person.find(:all, :limit => 50) rescue {} if !params[:q] || params[:q].strip.blank?
          
          people.each do |person|
              
              next if "#{person.names.first.given_name rescue nil} #{person.names.first.family_name rescue nil}".strip.blank?
              
              result = {
                "person"=>{
                    "attributes"=>[], 
                    "preferredName"=>{
                        "familyName2"=>nil, 
                        "givenName"=>"#{person.names.first.given_name rescue nil}", 
                        "familyName"=>"#{person.names.first.family_name rescue nil}", 
                        "uuid"=>"#{person.names.first.uuid rescue nil}", 
                        "links"=>[
                            {
                                "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/name/#{person.names.first.uuid rescue nil}", 
                                "rel"=>"self"
                            }, 
                            {
                                "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/name/#{person.names.first.uuid rescue nil}?v=full", 
                                "rel"=>"full"
                            }
                        ], 
                        "voided"=>false, 
                        "middleName"=>"#{person.names.first.middle_name rescue nil}", 
                        "resourceVersion"=>"1.8", 
                        "display"=>"#{person.names.first.given_name rescue nil} #{person.names.first.family_name rescue nil}"
                    }, 
                    "preferredAddress"=>{
                        "countyDistrict"=>nil, 
                        "preferred"=>true, 
                        "latitude"=>nil, 
                        "endDate"=>nil, 
                        "cityVillage"=>"#{person.addresses.first.city_village rescue nil}", 
                        "address6"=>"#{person.addresses.first.address6 rescue nil}", 
                        "address5"=>"#{person.addresses.first.address5 rescue nil}", 
                        "address4"=>"#{person.addresses.first.address4 rescue nil}", 
                        "address3"=>"#{person.addresses.first.address3 rescue nil}", 
                        "address2"=>"#{person.addresses.first.address2 rescue nil}", 
                        "address1"=>"#{person.addresses.first.address1 rescue nil}", 
                        "uuid"=>"#{person.addresses.first.uuid rescue nil}", 
                        "links"=>[
                            {
                                "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/address/#{person.addresses.first.uuid rescue nil}", 
                                "rel"=>"self"
                            }, 
                            {
                                "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/address/#{person.addresses.first.uuid rescue nil}?v=full", 
                                "rel"=>"full"
                            }
                        ], 
                        "voided"=>false, 
                        "country"=>nil, 
                        "stateProvince"=>"#{person.addresses.first.state_province rescue nil}", 
                        "postalCode"=>nil, 
                        "resourceVersion"=>"1.8", 
                        "longitude"=>nil, 
                        "startDate"=>nil, 
                        "display"=>nil
                    }, 
                    "causeOfDeath"=>nil, 
                    "auditInfo"=>{}, 
                    "birthdate"=>"#{person.birthdate.to_date.strftime("%Y-%m-%d") rescue nil}", 
                    "age"=>(((Date.today - person.birthdate.to_date).to_i / 365) rescue nil), 
                    "gender"=>"#{person.gender rescue nil}", 
                    "dead"=>false, 
                    "uuid"=>"#{person.uuid rescue nil}", 
                    "links"=>[
                        {
                            "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}", 
                            "rel"=>"self"
                        }
                    ], 
                    "deathDate"=>nil, 
                    "voided"=>false, 
                    "birthdateEstimated"=>"#{person.birthdate_estimated rescue nil}", 
                    "addresses"=>[
                        {
                            "countyDistrict"=>nil, 
                            "preferred"=>true, 
                            "latitude"=>nil, 
                            "endDate"=>nil, 
                            "cityVillage"=>"#{person.addresses.first.city_village rescue nil}", 
                            "address6"=>"#{person.addresses.first.address6 rescue nil}", 
                            "address5"=>"#{person.addresses.first.address5 rescue nil}", 
                            "address4"=>"#{person.addresses.first.address4 rescue nil}", 
                            "address3"=>"#{person.addresses.first.address3 rescue nil}", 
                            "address2"=>"#{person.addresses.first.address2 rescue nil}", 
                            "address1"=>"#{person.addresses.first.address1 rescue nil}", 
                            "uuid"=>"#{person.addresses.first.uuid rescue nil}", 
                            "links"=>[
                                {
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/address/#{person.addresses.first.uuid rescue nil}", 
                                    "rel"=>"self"
                                }, 
                                {
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/address/#{person.addresses.first.uuid rescue nil}?v=full", 
                                    "rel"=>"full"
                                }
                            ], 
                            "voided"=>false, 
                            "country"=>nil, 
                            "stateProvince"=>"#{person.addresses.first.state_province rescue nil}", 
                            "postalCode"=>nil, 
                            "resourceVersion"=>"1.8", 
                            "longitude"=>nil, 
                            "startDate"=>nil, 
                            "display"=>nil
                        }
                    ], 
                    "names"=>[
                        {
                            "familyName2"=>nil, 
                            "givenName"=>"#{person.names.first.given_name rescue nil}", 
                            "familyName"=>"#{person.names.first.family_name rescue nil}", 
                            "uuid"=>"#{person.names.first.uuid rescue nil}", 
                            "links"=>[
                                {
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/name/#{person.names.first.uuid rescue nil}", 
                                    "rel"=>"self"
                                }, 
                                {
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/name/#{person.names.first.uuid rescue nil}?v=full", 
                                    "rel"=>"full"
                                }
                            ], 
                            "voided"=>false, 
                            "middleName"=>"#{person.names.first.middle_name rescue nil}", 
                            "resourceVersion"=>"1.8", 
                            "display"=>"#{person.names.first.given_name rescue nil} #{person.names.first.family_name rescue nil}"
                        }
                    ], 
                    "resourceVersion"=>"1.8", 
                    "display"=>"#{person.names.first.given_name rescue nil} #{person.names.first.family_name rescue nil}"
                }, 
                "auditInfo"=>{}, 
                "identifiers"=>[
                    {
                        "preferred"=>true, 
                        "identifierType"=>{
                            "uuid"=>"#{person.patient.identifiers.first.type.uuid rescue nil}", 
                            "links"=>[
                                {
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/patientidentifiertype/#{person.patient.identifiers.first.type.uuid rescue nil}", 
                                    "rel"=>"self"
                                }
                            ], 
                            "display"=>"#{person.patient.identifiers.first.type.name rescue nil}"
                        }, 
                        "identifier"=>"#{person.patient.identifiers.first.identifier rescue nil}", 
                        "uuid"=>"#{person.patient.identifiers.first.uuid rescue nil}", 
                        "links"=>[
                            {
                                "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/patient/#{person.uuid rescue nil}/identifier/#{person.patient.identifiers.first.uuid rescue nil}", 
                                "rel"=>"self"
                            }, 
                            {
                                "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/patient/#{person.uuid rescue nil}/identifier/#{person.patient.identifiers.first.uuid rescue nil}?v=full", 
                                "rel"=>"full"
                            }
                        ], 
                        "voided"=>false, 
                        "location"=>{
                            "uuid"=>"#{person.patient.identifiers.first.location.uuid rescue nil}", 
                            "links"=>[
                                {
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{person.patient.identifiers.first.location.uuid rescue nil}", 
                                    "rel"=>"self"
                                }
                            ], 
                            "display"=>"Unknown Location"
                        }, 
                        "resourceVersion"=>"1.8", 
                        "display"=>"#{person.patient.identifiers.first.type.name rescue nil} = #{person.patient.identifiers.first.identifier rescue nil}"
                    }
                ], 
                "uuid"=>"#{person.uuid rescue nil}", 
                "links"=>[
                    {
                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/patient/#{person.uuid rescue nil}", 
                        "rel"=>"self"
                    }
                ], 
                "voided"=>false, 
                "resourceVersion"=>"1.8", 
                "display"=>"#{person.patient.identifiers.first.identifier rescue nil} - #{person.name rescue nil}"
            }
                        
            results["results"] << result
            
          end    
             
          render :json => results.to_json
        end
        
        def show
          result = {}
          
          if !params[:id].nil?
            person = Person.find(params[:id]) rescue {}
            
            if !person.blank?
                result = {
                    "person"=>{
                        "attributes"=>[], 
                        "preferredName"=>{
                            "familyName2"=>nil, 
                            "givenName"=>"#{person.names.first.given_name rescue nil}", 
                            "familyName"=>"#{person.names.first.family_name rescue nil}", 
                            "uuid"=>"#{person.names.first.uuid rescue nil}", 
                            "links"=>[
                                {
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/name/#{person.names.first.uuid rescue nil}", 
                                    "rel"=>"self"
                                }, 
                                {
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/name/#{person.names.first.uuid rescue nil}?v=full", 
                                    "rel"=>"full"
                                }
                            ], 
                            "voided"=>false, 
                            "middleName"=>"#{person.names.first.middle_name rescue nil}", 
                            "resourceVersion"=>"1.8", 
                            "display"=>"#{person.names.first.given_name rescue nil} #{person.names.first.family_name rescue nil}"
                        }, 
                        "preferredAddress"=>{
                            "countyDistrict"=>nil, 
                            "preferred"=>true, 
                            "latitude"=>nil, 
                            "endDate"=>nil, 
                            "cityVillage"=>"#{person.addresses.first.city_village rescue nil}", 
                            "address6"=>"#{person.addresses.first.address6 rescue nil}", 
                            "address5"=>"#{person.addresses.first.address5 rescue nil}", 
                            "address4"=>"#{person.addresses.first.address4 rescue nil}", 
                            "address3"=>"#{person.addresses.first.address3 rescue nil}", 
                            "address2"=>"#{person.addresses.first.address2 rescue nil}", 
                            "address1"=>"#{person.addresses.first.address1 rescue nil}", 
                            "uuid"=>"#{person.addresses.first.uuid rescue nil}", 
                            "links"=>[
                                {
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/address/#{person.addresses.first.uuid rescue nil}", 
                                    "rel"=>"self"
                                }, 
                                {
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/address/#{person.addresses.first.uuid rescue nil}?v=full", 
                                    "rel"=>"full"
                                }
                            ], 
                            "voided"=>false, 
                            "country"=>nil, 
                            "stateProvince"=>"#{person.addresses.first.state_province rescue nil}", 
                            "postalCode"=>nil, 
                            "resourceVersion"=>"1.8", 
                            "longitude"=>nil, 
                            "startDate"=>nil, 
                            "display"=>nil
                        }, 
                        "causeOfDeath"=>nil, 
                        "auditInfo"=>{}, 
                        "birthdate"=>"#{person.birthdate.to_date.strftime("%Y-%m-%d") rescue nil}", 
                        "age"=>(((Date.today - person.birthdate.to_date).to_i / 365) rescue nil), 
                        "gender"=>"#{person.gender rescue nil}", 
                        "dead"=>false, 
                        "uuid"=>"#{person.uuid rescue nil}", 
                        "links"=>[
                            {
                                "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}", 
                                "rel"=>"self"
                            }
                        ], 
                        "deathDate"=>nil, 
                        "voided"=>false, 
                        "birthdateEstimated"=>"#{person.birthdate_estimated rescue nil}", 
                        "addresses"=>[
                            {
                                "countyDistrict"=>nil, 
                                "preferred"=>true, 
                                "latitude"=>nil, 
                                "endDate"=>nil, 
                                "cityVillage"=>"#{person.addresses.first.city_village rescue nil}", 
                                "address6"=>"#{person.addresses.first.address6 rescue nil}", 
                                "address5"=>"#{person.addresses.first.address5 rescue nil}", 
                                "address4"=>"#{person.addresses.first.address4 rescue nil}", 
                                "address3"=>"#{person.addresses.first.address3 rescue nil}", 
                                "address2"=>"#{person.addresses.first.address2 rescue nil}", 
                                "address1"=>"#{person.addresses.first.address1 rescue nil}", 
                                "uuid"=>"#{person.addresses.first.uuid rescue nil}", 
                                "links"=>[
                                    {
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/address/#{person.addresses.first.uuid rescue nil}", 
                                        "rel"=>"self"
                                    }, 
                                    {
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/address/#{person.addresses.first.uuid rescue nil}?v=full", 
                                        "rel"=>"full"
                                    }
                                ], 
                                "voided"=>false, 
                                "country"=>nil, 
                                "stateProvince"=>"#{person.addresses.first.state_province rescue nil}", 
                                "postalCode"=>nil, 
                                "resourceVersion"=>"1.8", 
                                "longitude"=>nil, 
                                "startDate"=>nil, 
                                "display"=>nil
                            }
                        ], 
                        "names"=>[
                            {
                                "familyName2"=>nil, 
                                "givenName"=>"#{person.names.first.given_name rescue nil}", 
                                "familyName"=>"#{person.names.first.family_name rescue nil}", 
                                "uuid"=>"#{person.names.first.uuid rescue nil}", 
                                "links"=>[
                                    {
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/name/#{person.names.first.uuid rescue nil}", 
                                        "rel"=>"self"
                                    }, 
                                    {
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{person.uuid rescue nil}/name/#{person.names.first.uuid rescue nil}?v=full", 
                                        "rel"=>"full"
                                    }
                                ], 
                                "voided"=>false, 
                                "middleName"=>"#{person.names.first.middle_name rescue nil}", 
                                "resourceVersion"=>"1.8", 
                                "display"=>"#{person.names.first.given_name rescue nil} #{person.names.first.family_name rescue nil}"
                            }
                        ], 
                        "resourceVersion"=>"1.8", 
                        "display"=>"#{person.names.first.given_name rescue nil} #{person.names.first.family_name rescue nil}"
                    }, 
                    "auditInfo"=>{}, 
                    "identifiers"=>[
                        {
                            "preferred"=>true, 
                            "identifierType"=>{
                                "uuid"=>"#{person.patient.identifiers.first.type.uuid rescue nil}", 
                                "links"=>[
                                    {
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/patientidentifiertype/#{person.patient.identifiers.first.type.uuid rescue nil}", 
                                        "rel"=>"self"
                                    }
                                ], 
                                "display"=>"#{person.patient.identifiers.first.type.name rescue nil}"
                            }, 
                            "identifier"=>"#{person.patient.identifiers.first.identifier rescue nil}", 
                            "uuid"=>"#{person.patient.identifiers.first.uuid rescue nil}", 
                            "links"=>[
                                {
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/patient/#{person.uuid rescue nil}/identifier/#{person.patient.identifiers.first.uuid rescue nil}", 
                                    "rel"=>"self"
                                }, 
                                {
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/patient/#{person.uuid rescue nil}/identifier/#{person.patient.identifiers.first.uuid rescue nil}?v=full", 
                                    "rel"=>"full"
                                }
                            ], 
                            "voided"=>false, 
                            "location"=>{
                                "uuid"=>"#{person.patient.identifiers.first.location.uuid rescue nil}", 
                                "links"=>[
                                    {
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/location/#{person.patient.identifiers.first.location.uuid rescue nil}", 
                                        "rel"=>"self"
                                    }
                                ], 
                                "display"=>"Unknown Location"
                            }, 
                            "resourceVersion"=>"1.8", 
                            "display"=>"#{person.patient.identifiers.first.type.name rescue nil} = #{person.patient.identifiers.first.identifier rescue nil}"
                        }
                    ], 
                    "uuid"=>"#{person.uuid rescue nil}", 
                    "links"=>[
                        {
                            "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/patient/#{person.uuid rescue nil}", 
                            "rel"=>"self"
                        }
                    ], 
                    "voided"=>false, 
                    "resourceVersion"=>"1.8", 
                    "display"=>"#{person.patient.identifiers.first.identifier rescue nil} - #{person.name rescue nil}"
                }
                              
            end
            
          end
        
          render :json => result.to_json
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
