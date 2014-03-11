class Patient < ActiveRecord::Base
  set_table_name "patient"
  set_primary_key "patient_id"
  
  def identifiers 
    PatientIdentifier.find(:all, :conditions => ["patient_id = ?", self.patient_id])
  end
  
  def person
    Person.find_by_person_id(self.patient_id) rescue nil
  end
  
end
