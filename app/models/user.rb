class User < ActiveRecord::Base
  rolify
  include Authentication
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :omniauth_accounts

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :first_name, :last_name, :user_name, :email, :birthday , :as => :admin
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :user_name, :birthday

  def role_name
    read_attribute("role_name") || roles.first.name
  end

  def role_id
    read_attribute("role_id") || roles.first.id
  end

  def email_required?
		super && !created_omniauth_origin? 
  end

	def password_required?
		super && !created_omniauth_origin? 
	end
end
