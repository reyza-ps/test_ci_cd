class ConnectorsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_connector, only: [:show]

  def index
    @q = Connector.order('created_at desc').ransack(params[:q])
    @pagy, @connectors = pagy(@q.result(distinct: true), items: 10)
  end

  def show; end

  private

  def set_connector
    @connector = Connector.find(params[:id])
  end
end
