module CMSAccessControl
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user
    before_action :session_and_stuff
    around_action :configure_time_zone
    layout 'cms'
  end

  def session_and_stuff
    @current_user = User.includes(:access_profile).find_by(id: session[:sess_user], status: User.statuses[:active]) if session[:sess_user]
    if @current_user.nil?
      flash[:alert] = t('cms.alerts.not_logged_in')
      redirect_to :cms_root
    else
      @breadcrumbs = []
    end
  end

  def configure_time_zone(&block)
    Time.use_zone(@current_user.time_zone.blank? ? 'UTC' : @current_user.time_zone, &block)
  end
end
