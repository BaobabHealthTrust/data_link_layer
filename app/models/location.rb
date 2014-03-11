class Location < ActiveRecord::Base
  set_table_name "location"
  set_primary_key "uuid"
  
  def parent
    Location.find_by_location_id(self.parent_location) rescue nil
  end
end
