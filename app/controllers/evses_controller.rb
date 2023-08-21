class EvsesController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_evse, only: [:show]

  def index
    @evses = Evse.order('created_at asc')
  end

  def show
  end

  private

  def set_evse
    @evse = Evse.find(params[:id])
  end
end
