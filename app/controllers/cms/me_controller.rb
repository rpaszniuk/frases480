class CMS::MeController < ApplicationController
  include CMSAccessControl
  before_action :permissions_and_breadcrumbs

  def show
    @user = @current_user
  end

  private

  def permissions_and_breadcrumbs
    case params[:action]
    when 'show'
      @page_title = 'Perfil'
      @breadcrumbs << { label: 'Perfil' }
    end
  end
end
