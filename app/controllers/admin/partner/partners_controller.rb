class Admin::Partner::PartnersController < AdminController
  before_action :set_partner, only: [:show, :edit, :update]
  
  def index
    @q = Partner::Partner.ransack(params[:q])
    @pagy, @partners = pagy(@q.result(distinct: true), items: 5)
  end

  def show
    @applications = @partner.oauth_applications.order(id: :desc)#.page(params[:page])
  end

  def edit; end

  def update
    if @partner.update(partner_params)
      # @partner.generate_partner_charger_group(params[:partner_charger_groups])
      redirect_to admin_partners_path, flash: { success: 'Partner updated successfully.' }
    else
      render :edit
    end
  end

  private

  def set_partner
    @partner = Partner::Partner.find_by(id: params[:id])
  end

  def partner_params
    params.require(:partner_partner).permit(:code, :name, :address, :city, :state, :country, :postcode,
      :overview, :registration_no, :website_url, :logo,  :email, :mobile_phone, :user_id, :party_id,
      :country_code, :ocpi_percentage_fee, :charger_group_option, :partner_charger_groups)
  end
end
