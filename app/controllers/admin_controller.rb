class AdminController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!

  layout "admin"
end
