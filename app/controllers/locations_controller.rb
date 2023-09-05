class LocationsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_location, only: [:show]

  def index
    @q = Location.order('created_at desc').ransack(params[:q])
    @pagy, @locations = pagy(@q.result(distinct: true), items: 10)
  end

  def show; end

  private

  def set_location
    @location = Location.find(params[:id])
    @business_details = BusinessDetail.all
    # @api_request_logs = Partner::ApiRequestLog.where("endpoint LIKE ? AND endpoint LIKE ?", '%locations%', "%#{@location.uid}%")
    #                       .where(request_type: (@readonly ? 'incoming' : 'outgoing'))
    #                       .order("created_at desc")
    #                       .limit(25)
    @api_request_logs = Partner::ApiRequestLog.order("created_at desc").limit(25)
  end
end
