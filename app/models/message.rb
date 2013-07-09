class Message

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :subject, :body

  validates :name, :email, :subject, :body, :presence => true
  validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true
  
  def initialize(user = nil, attributes = {})
    if user
      @name = user.user_name
      @email = user.email
    else
      @name = attributes[:name]
      @email = attributes[:email]
    end
    @subject = attributes[:subject]
    @body = attributes[:body]
  end

  def persisted?
    false
  end

end

