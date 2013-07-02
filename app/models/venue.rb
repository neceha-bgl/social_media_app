class Venue < ActiveRecord::Base
  attr_accessible :address, :city, :state, :zipcode, :as => :admin
  belongs_to :user
end
