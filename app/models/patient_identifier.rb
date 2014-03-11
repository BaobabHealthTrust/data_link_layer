class PatientIdentifier < ActiveRecord::Base
  set_table_name "patient_identifier"
  set_primary_key "uuid"
  
  def type 
    PatientIdentifierType.find_by_patient_identifier_type_id(self.identifier_type) rescue nil
  end
  
  def location 
    Location.find_by_location_id(self.location_id) rescue nil
  end
  
end
