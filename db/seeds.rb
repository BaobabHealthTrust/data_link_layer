# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

lookup = {
    "Respiratory rate".downcase => "5242AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "Temperature (C)".downcase => "5088AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "SYSTOLIC BLOOD PRESSURE".downcase => "5085AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "DIASTOLIC BLOOD PRESSURE".downcase => "5086AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "Weight (kg)".downcase => "5089AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "Height (cm)".downcase => "5090AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "Blood oxygen saturation".downcase => "5092AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    "Pulse".downcase => "5087AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
} 

Concept.find_by_sql("SELECT n.name AS short_name, c.uuid FROM concept c " + 
        "LEFT OUTER JOIN concept_name n ON n.concept_id = c.concept_id " + 
        "WHERE name IN ('Respiratory rate','Temperature (C)','SYSTOLIC BLOOD " + 
        "PRESSURE','DIASTOLIC BLOOD PRESSURE','Weight (kg)','Height (cm)'," + 
        "'Blood oxygen saturation','Pulse')").each{|c| 
            c.update_attributes(:uuid => lookup[c.short_name.downcase])
            
            puts "Updated uuid for #{c.short_name} to #{c.uuid}"
        }
