class UserSession < Authlogic::Session::Base
  find_by_login_method :find_by_email #for example or you can make what ever method 
  generalize_credentials_error_messages "Try again"
  def to_key
     new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
  
  def persisted?
    false
  end
end