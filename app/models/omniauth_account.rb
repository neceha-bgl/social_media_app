class OmniauthAccount < ActiveRecord::Base
  include Authentication
  belongs_to :user
  validates :provider, :uid, :presence => true
end
