class Venue < ActiveRecord::Base
  attr_accessible :address, :city, :state, :zipcode
  attr_accessible :address, :city, :state, :zipcode, :as => :admin
  belongs_to :user
  acts_as_gmappable
  geocoded_by :gmaps4rails_address
  after_validation :geocode 

  def gmaps4rails_address
    "#{address}, #{zipcode}, #{city}, France"
  end
end
