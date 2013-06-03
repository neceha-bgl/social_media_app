class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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

end
