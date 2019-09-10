class CMS::LoginController < ApplicationController
  def index
    unless session[:sess_user].nil?
      user = User.includes(:access_profile).find_by(id: session[:sess_user], status: User.statuses[:active])
      if !user.nil?
        reset_session
        session[:sess_user] = nil
        redirect_to :cms_root
      else
        redirect_to :cms_dashboard
      end
      return
    end

    @user_auth = UserAuth.new

    render layout: 'cms_empty'
  end
end
