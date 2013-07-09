class ContactController < ApplicationController

  add_breadcrumb "Home", :root_path

  def new
    add_breadcrumb "Contact", :contact_path
    @message = Message.new
    render 'authenticated_new' and return if user_signed_in?
  end

  def create
    @message = Message.new(current_user, params[:message])
    
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
    else
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end

end

