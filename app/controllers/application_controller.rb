class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :miniprofiler

  private
  def miniprofiler
    Rack::MiniProfiler.authorize_request  if request.remote_ip.eql?(ENV["PROTECTED_REMOTE_IP"])
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
end
