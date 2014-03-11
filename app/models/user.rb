class User < ActiveRecord::Base
  set_table_name "users"
  set_primary_key "uuid"
  
  def self.authenticated?(username, password)
    user = self.find_by_username(username) rescue nil
    
    return false if user.nil?
  
    pass = Digest::SHA1.hexdigest("#{password}#{user.salt rescue ""}")
    
    return true if user.password == pass 
    
    return false
  end
  
  def person
    Person.find_by_person_id(self.person_id) rescue nil
  end
  
  def name
    person.name rescue nil
  end
  
end
