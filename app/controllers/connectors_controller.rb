class ConnectorsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_connector, only: [:show]

  def index
    @connectors = Connector.order('created_at desc')
  end

  def show
  end

  private

  def set_connector
    @connector = Connector.find(params[:id])
  end
end
