class LogsController < ApplicationController
  layout 'admin'
  
  def index
    @q = Partner::ApiRequestLog.order("created_at desc").ransack(params[:q])
    @pagy, @logs = pagy(@q.result(distinct: true), items: 10)
  end

  def show
    @log =  Partner::ApiRequestLog.find_by(id: params[:id])
  end

  private

  def set_log
  end
end
