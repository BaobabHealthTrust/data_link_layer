class Encounter < ActiveRecord::Base
  set_table_name "encounter"
  set_primary_key "encounter_id"
  
  def encountertype
    EncounterType.find_by_encounter_type_id(self.encounter_type) rescue nil
  end
  
  def type 
    encountertype.name rescue nil
  end
  
  def obs
    Obs.find(:all, :conditions => ["encounter_id = ? AND voided = 0", self.encounter_id])
  end
  
  def patient
    Patient.find_by_patient_id(self.patient_id) rescue nil
  end
  
  def location
    Location.find_by_location_id(self.location_id) rescue nil
  end
  
  def provider
    user = User.find_by_user_id(self.creator) rescue nil
    
    Person.find_by_person_id(user.person_id) rescue nil
  end
  
  def self.guuid
    ActiveRecord::Base.connection.select_one("SELECT UUID() as uuid")['uuid']
  end
  
end
