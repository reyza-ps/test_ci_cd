class Admin::AdminsController < AdminController
  before_action :set_admin, only: [:show, :edit, :update]
  
  def index
    @q = User.ransack(params[:q])
    @pagy, @admins = pagy(@q.result(distinct: true), items: 5)
  end

  def show
  end

  def new
    @admin = User.new
  end

  def edit; end

  def update

  end

  private

  def set_admin
    @admin = User.find_by(id: params[:id])
  end

  def admin_params
  end
end
