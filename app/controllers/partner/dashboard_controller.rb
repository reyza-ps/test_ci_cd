class Partner::DashboardController < Partner::BaseController
  def index
    current_partner_apps = current_partner.applications.pluck(:id)
    # unless current_partner_apps.blank?
    #   @api_req_log_today = ::Partner::ApiRequestLog.by_today(current_partner_apps).page(params[:by_today]).per(5)
    #   @api_req_log_this_week  = ::Partner::ApiRequestLog.by_this_week(current_partner_apps).page(params[:by_this_week]).per(5)
    #   @api_req_log_this_month = ::Partner::ApiRequestLog.by_this_months(current_partner_apps).page(params[:by_this_months]).per(5)
    # end
  end

  def arl_details
    @api_requ_log = ::Partner::ApiRequestLog.find_by_id(params[:arl_id])
  end
end
