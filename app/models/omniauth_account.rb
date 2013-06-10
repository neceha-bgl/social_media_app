class OmniauthAccount < ActiveRecord::Base
  include Authentication
  belongs_to :user
  validates :provider, :uid, :presence => true

  def user_name
   user.nil? ? "" : user.user_name
  end
end
