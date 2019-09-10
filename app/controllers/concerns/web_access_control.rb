module WEBAccessControl
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user
    before_action :session_and_stuff
    layout 'web'
  end

  def session_and_stuff
    @current_user = User.includes(:access_profile).find_by(id: session[:sess_user], status: User.statuses[:active]) if session[:sess_user]
    @breadcrumbs = []
  end
end
