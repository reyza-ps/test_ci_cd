class Partner::MembersController < Partner::BaseController
  layout 'partner'
  skip_before_action :authenticate_partner!, only: [:new, :create]
  before_action :set_application, only: [:new, :create, :destroy]

  def index
    @members = ::Partner::Partner.joins(:applications => :partners).where('developer_partners_oauth_applications_join.partner_id = ?', current_partner.id).uniq
  end

  def new;end

  def create
    partner = Partner::Partner.find_by_email(member_params[:email])
    unless @application.has_member?(partner.try(:id))
      payload = {
        name: "#{@application.owner.name}-Developer",
        address: @application.owner.address,
        city: @application.owner.city,
        state: @application.owner.state,
        country: @application.owner.country,
        postcode: @application.owner.postcode,
        overview: @application.owner.overview,
        website_url: @application.owner.website_url,
        password: '12345678' 
      }

      if partner.present?
        @application.add_to_members(member_id: partner.id)
        redirect_to oauth_applications_path, notice: 'Member successfully invited'
      else
        @member = ::Partner::Partner.new(member_params.merge(payload))
        if @member.save
          @application.add_to_members(member_id: @member.id)
          redirect_to oauth_applications_path, notice: 'Member invited, please check member email for confirmation'
        else
          redirect_to oauth_applications_path, alert: @member.errors.full_messages.first
        end
      end
    else
      redirect_to oauth_applications_path, notice: 'Already join as members'
    end
  end

  def arl_details
    @api_requ_log = ::Partner::ApiRequestLog.find_by_id(params[:arl_id])
  end

  def destroy
    application = ::Partner::Application.find_by_id(params[:application_id])
    dev_partner = ::Partner::DeveloperPartner.find_by_partner_id_and_application_id(params[:id], application.try(:id))
    if dev_partner.present? && (params[:id].to_i != application.owner_id)
      dev_partner.destroy
      redirect_to oauth_application_path(application.try(:id)), notice: 'Member successfully remove from application'
    else
      redirect_to oauth_application_path(application.try(:id)), alert: 'Opss! Can not remove members from application'
    end
  end

  private
  def member_params
    params.require(:members).permit(:email, :mobile_phone)
  end

  def set_application
    @application = ::Partner::Application.find_by_uid(params[:uid])
  end

end
