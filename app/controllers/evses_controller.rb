class EvsesController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_evse, only: [:show]

  def index
    @q = Evse.order('created_at desc').ransack(params[:q])
    @pagy, @evses = pagy(@q.result(distinct: true), items: 10)
  end

  def show
  end

  private

  def set_evse
    @evse = Evse.find(params[:id])
  end
end
