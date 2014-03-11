class Obs < ActiveRecord::Base
  set_table_name "obs"
  set_primary_key "obs_id"
  
  def value 
    value = nil
    
    value = self.value_text if !self.value_text.blank?
    
    value = self.value_datetime if !self.value_datetime.blank?
    
    value = self.value_numeric if !self.value_numeric.blank?
    
    value = self.value_boolean if !self.value_boolean.blank?
    
    if !self.value_coded.blank?
        code = Concept.find_by_concept_id(self.value_coded) rescue nil
    
        value = code.name if !code.nil? 
    end
    
    value
    
  end
  
  def concept
    Concept.find_by_concept_id(self.concept_id) rescue nil
  end
  
  def location
    Location.find_by_location_id(self.location_id) rescue nil
  end
  
  def encounter
    Encounter.find_by_encounter_id(self.encounter_id) rescue nil
  end
  
  def person
    Person.find_by_person_id(self.person_id) rescue nil
  end
  
end
