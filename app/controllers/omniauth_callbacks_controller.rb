class OmniauthCallbacksController < ApplicationController
  def create
    if user_signed_in?
      omniauth_account = current_user.add_omniauth_account(request.env["omniauth.auth"])
      unless omniauth_account.user.eql? current_user
        redirect_to root_url, :notice => "Account already affected to an other user" and return 
      end
      flash.notice = "You can now login using #{request.env["omniauth.auth"].provider.capitalize} too!"
      redirect_to root_url
    else
      user , omniauth_account = User.find_with_auth(request.env["omniauth.auth"])
      if user.persisted?
        flash.notice = "Signed in!"
        sign_in_and_redirect user
      else
        session["devise.user_attributes"] = user.attributes
        session["devise.omniauth_account_id"] = omniauth_account.id
        redirect_to new_user_registration_url
      end
    end
  end
  alias_method :facebook , :create
  def failure
    render 'omniauth_accounts/failure'
  end
end
