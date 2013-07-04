class HomeController < ApplicationController
  def index
    @json = Venue.all.to_gmaps4rails
  end
end
