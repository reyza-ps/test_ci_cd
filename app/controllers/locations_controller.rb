class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location, only: [:show, :edit, :update, :destroy, :clear_cache]

  def index
    @locations = Location.order('created_at asc')
  end

  def show; end

  private

  def set_location
    @location = Location.find(params[:id])
  end
end
