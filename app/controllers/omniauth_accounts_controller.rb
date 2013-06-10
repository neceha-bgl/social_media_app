class OmniauthAccountsController < ApplicationController
  before_filter :refresh, :only => [:show, :account]

  def account
    add_breadcrumb "Social accounts", :accounts_path
    @omniauth_account = current_user.get_omniauth_account_by_provider params[:provider]
    unless @omniauth_account 
      redirect_to root_path, :notice => "Provider not found"  and return 
    end

    unless @omniauth_account.valid_token?
      redirect_to user_omniauth_authorize_path  @omniauth_account.provider and return
    end

    add_breadcrumb @omniauth_account.provider, account_path(@omniauth_account.provider)
    render  @omniauth_account.provider 
  end

  def show
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @omniauth_account = OmniauthAccount.find(params[:id])
    unless @omniauth_account 
      redirect_to omniauth_accounts_path, :notice => "Provider not found"  and return 
    end

    add_breadcrumb "Omniauth accounts", :omniauth_accounts_path
    add_breadcrumb @omniauth_account.provider, omniauth_account_path(@omniauth_account.id)
    render  @omniauth_account.provider 
  end

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

  private
  def refresh
    @options = params[:refresh] ?  {refresh_cache: true} : {}
  end

end
