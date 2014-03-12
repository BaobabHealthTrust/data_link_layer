class Concept < ActiveRecord::Base
  set_table_name "concept"
  set_primary_key "concept_id"
  
  def names
    ConceptName.find(:all, :conditions => ["concept_id = ?", self.concept_id]) rescue []
  end
  
  def name
    names.first.name rescue nil
  end
  
end
