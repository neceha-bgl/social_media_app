class Venue < ActiveRecord::Base
  attr_accessible :address, :city, :state, :zipcode
  belongs_to :user
end
