class ClientInfosController < ApplicationController
  layout 'admin'

  def index
    @parties = HubClientInfo.select('party_id, country_code, COUNT(party_id) AS total').group(:party_id, :country_code)
    @client_infos = if params[:party_id].present?
                      @q = HubClientInfo.order('created_at desc').where(party_id: params[:party_id]).ransack(params[:q])
                      @q.result
                    else
                      @q = HubClientInfo.order('created_at desc').ransack(params[:q])
                      @q.result
                    end
    @pagy, @client_infos = pagy(@q.result(distinct: true), items: 10)
  end
end
