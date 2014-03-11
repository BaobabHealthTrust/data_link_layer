module Ws
    module Rest
        module V1
            class UserController < ApplicationController

                def index
                    results = {"results" => []}

                    users = User.find(:all, :limit => 50) rescue []

                    users.each do |user|

                        result = {
                            "resourceVersion"=>"1.8", 
                            "auditInfo"=>{}, 
                            "dateChanged"=>nil, 
                            "systemId"=>"#{user.system_id rescue nil}", 
                            "privileges"=>[], 
                            "display"=>"#{user.username rescue nil}", 
                            "links"=>[
                                {
                                    "rel"=>"self", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/user/#{user.uuid rescue ""}"
                                }
                            ], 
                            "userProperties"=>{}, 
                            "allRoles"=>[], 
                            "username"=>"#{user.username rescue nil}", 
                            "proficientLocales"=>[], 
                            "retired"=>false, 
                            "roles"=>[], 
                            "person"=>{
                                "resourceVersion"=>"1.8", 
                                "preferredName"=>{
                                    "display"=>"#{user.name rescue nil}", 
                                    "links"=>[
                                        {
                                            "rel"=>"self", 
                                            "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{user.person.uuid rescue nil}/name/#{user.person.names.first.uuid rescue nil}"
                                        }
                                    ], 
                                    "uuid"=>"#{user.person.uuid rescue nil}"
                                }, 
                                "gender"=>"#{user.person.gender rescue nil}", 
                                "display"=>"#{user.person.name rescue nil}", 
                                "voided"=>false, 
                                "causeOfDeath"=>nil, 
                                "deathDate"=>nil, 
                                "birthdateEstimated"=>"#{user.person.birthdate_estimated rescue nil}", 
                                "links"=>[
                                    {
                                        "rel"=>"self", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{user.person.uuid rescue nil}"
                                    }, 
                                    {
                                        "rel"=>"full", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{user.person.uuid rescue nil}?v=full"
                                    }
                                ], 
                                "preferredAddress"=>nil, 
                                "age"=>nil, 
                                "birthdate"=>"", 
                                "uuid"=>"#{user.person.uuid rescue nil}", 
                                "attributes"=>[], 
                                "dead"=>false
                            }, 
                            "uuid"=>"#{user.uuid rescue ""}", 
                            "secretQuestion"=>nil
                        }

                        results["results"] << result
                    end

                    render :json => results.to_json

                end

                def show
                    result = {}

                    user = User.find(params[:id]) rescue {}

                    if !user.blank?

                    result = {
                            "resourceVersion"=>"1.8", 
                            "auditInfo"=>{}, 
                            "dateChanged"=>nil, 
                            "systemId"=>"#{user.system_id rescue nil}", 
                            "privileges"=>[], 
                            "display"=>"#{user.username rescue nil}", 
                            "links"=>[
                                {
                                    "rel"=>"self", 
                                    "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/user/#{user.uuid rescue ""}"
                                }
                            ], 
                            "userProperties"=>{}, 
                            "allRoles"=>[], 
                            "username"=>"#{user.username rescue nil}", 
                            "proficientLocales"=>[], 
                            "retired"=>false, 
                            "roles"=>[], 
                            "person"=>{
                                "resourceVersion"=>"1.8", 
                                "preferredName"=>{
                                    "display"=>"#{user.name rescue nil}", 
                                    "links"=>[
                                        {
                                            "rel"=>"self", 
                                            "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{user.person.uuid rescue nil}/name/#{user.person.names.first.uuid rescue nil}"
                                        }
                                    ], 
                                    "uuid"=>"#{user.person.uuid rescue nil}"
                                }, 
                                "gender"=>"#{user.person.gender rescue nil}", 
                                "display"=>"#{user.person.name rescue nil}", 
                                "voided"=>false, 
                                "causeOfDeath"=>nil, 
                                "deathDate"=>nil, 
                                "birthdateEstimated"=>"#{user.person.birthdate_estimated rescue nil}", 
                                "links"=>[
                                    {
                                        "rel"=>"self", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{user.person.uuid rescue nil}"
                                    }, 
                                    {
                                        "rel"=>"full", 
                                        "uri"=>"NEED-TO-CONFIGURE/ws/rest/v1/person/#{user.person.uuid rescue nil}?v=full"
                                    }
                                ], 
                                "preferredAddress"=>nil, 
                                "age"=>nil, 
                                "birthdate"=>"", 
                                "uuid"=>"#{user.person.uuid rescue nil}", 
                                "attributes"=>[], 
                                "dead"=>false
                            }, 
                            "uuid"=>"#{user.uuid rescue ""}", 
                            "secretQuestion"=>nil
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
