class LocationsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_location, only: [:show]

  def index
    @locations = Location.order('created_at desc')
  end

  def show; end

  private

  def set_location
    @location = Location.find(params[:id])
  end
end
