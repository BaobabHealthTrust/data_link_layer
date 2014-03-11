class PersonName < ActiveRecord::Base
  set_table_name "person_name"
  set_primary_key "uuid"
  
  def person
    Person.find_by_person_id(self.person_id) rescue nil
  end
  
end
