class Admin::PartnersController < AdminController
  before_action :set_partner, only: [:show, :edit, :update]
  
  def index
    @q = Partner::Partner.ransack(params[:q])
    @partners = @q.result(distinct: true)
  end

  def show
    @applications = @partner.oauth_applications.order(id: :desc)#.page(params[:page])
  end

  def update
    
  end

  private

  def set_partner
    @partner = Partner::Partner.find_by(id: params[:id])
  end
end
