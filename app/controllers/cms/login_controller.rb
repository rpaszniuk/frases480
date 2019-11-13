class CMS::LoginController < ApplicationController
  def index
    unless session[:sess_user].nil?
      redirect_to :cms_dashboard
      return
    end

    @user_auth = UserAuth.new
    render layout: 'cms_empty'
  end
end
