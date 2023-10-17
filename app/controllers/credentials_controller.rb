class CredentialsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :set_credential, only: [:show]

  def index
    @q = Credential.order('created_at desc').ransack(params[:q])
    @pagy, @credentials = pagy(@q.result(distinct: true), items: 10)
  end

  def show
    @endpoints = Ocpi::Domain::Versions::Models::Endpoint.joins(
      version_detail: {
        version: :credential
      }
    ).where('ocpi_credentials.id = ?', @credential.id)
                                                         .order(identifier: :asc)
    @credential_roles = @credential.credential_roles.includes(:business_detail, :role)
  end

  private

  def set_credential
    @credential = Credential.find(params[:id])
  end
end
