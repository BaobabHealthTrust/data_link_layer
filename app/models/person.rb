class Person < ActiveRecord::Base
  set_table_name "person"
  set_primary_key "uuid"
  
  default_scope :conditions => "#{self.table_name}.voided = 0" 
  
  def names
    PersonName.find(:all, :conditions => ["person_id = ? AND voided = 0", self.person_id])
  end
  
  def name
    result = names.first rescue nil
    
    "#{result.given_name} #{result.family_name}" rescue nil
  end
  
  def addresses
    PersonAddress.find(:all, :conditions => ["person_id = ? AND voided = 0", self.person_id])
  end
  
  def patient
    Patient.find_by_patient_id(self.person_id)
  end
end
