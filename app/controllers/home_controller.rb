class HomeController < ApplicationController

  def index
    if params[:location].present?
      @venues = Venue.near(params[:location], params[:distance] || 10, order: :distance)
    else
      @venues = Venue.all
    end
    @json = @venues.to_gmaps4rails do |venue, marker|
      marker.title   venue.gmaps4rails_address
    end
    render 'index'
  end
end
