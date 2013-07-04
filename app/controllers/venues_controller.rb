class VenuesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_venue, only: [:show, :update, :destroy]

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @venues = Venue.paginate(:page => params[:page], :per_page => 25)
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(params[:venue])
    @venue.user = current_user 
    respond_to do |format|
      if @venue.save
        format.html  { redirect_to(@venue,
                      :notice => 'Post was successfully created.') }
        format.json  { render :json => @venue,
                      :status => :created, :location => @venue }
        format.js
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @venue.errors,
                      :status => :unprocessable_entity }
        format.js
      end
    end
  end

  def show
    @json = @venue.to_gmaps4rails
  end

  def update
    respond_to do |format|
      if @venue.update_attributes(params[:venue], :as => :admin)
        format.html {redirect_to :back , :notice => "Venue updated."}
        format.json {head :no_content}
      else
        format.html {redirect_to :back, :alert => "Unable to update user." }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to user_account_path, :notice => "Venue deleted."  }
      format.js 
    end
  end

  def find_venue
    if current_user.has_role? :admin
      @venue = Venue.find(params[:id])
    else
      @venue = current_user.venues.find(params[:id])
    end
    authorize! :manage, @venue, :message => 'Not authorized as an administrator.'
  end
end
