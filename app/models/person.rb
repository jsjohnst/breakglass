class Person < ActiveRecord::Base
	belongs_to :family
	has_many :messages
	validates_format_of :phone, :with => /[0-9]{10}/
  validates_uniqueness_of :phone

	validates_presence_of :family
	
	def self.strip_nonnumeric(phone)
	  phone.gsub /[^0-9]/, ''
  end
  
  def phone=(phone)
    self[:phone] = Person.strip_nonnumeric phone
  end
	
	def self.authenticate(phone, password)
	  person = find_by_phone strip_nonnumeric(phone)
	  if person && person.family.authenticated?(password)
	    person
    else
      nil
    end
  end
end
