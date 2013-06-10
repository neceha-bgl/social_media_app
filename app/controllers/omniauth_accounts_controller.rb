class OmniauthAccountsController < ApplicationController
  def accounts 
    add_breadcrumb "Social accounts", :accounts_path
    @omniauth_accounts = current_user.omniauth_accounts
  end

  def index 
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    add_breadcrumb "Omniauth accounts", :omniauth_accounts_path
    term  = params[:search]
    @omniauth_accounts = OmniauthAccount.includes(:user).where("provider like :term", term: "%#{term}%").paginate(:page => params[:page], :per_page => 10)
  end

end
