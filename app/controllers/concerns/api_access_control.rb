module APIAccessControl
  extend ActiveSupport::Concern

  included do
    skip_before_action :verify_authenticity_token
    attr_reader :request_user
    before_action :authenticate
    before_action :set_raven_context
  end

  def authenticate
    if request.headers['X-Application-Secret'] == Newfrases480::Application.credentials.app_secret
      if user = authenticate_with_http_token { |token, _options| User.find_by(auth_token: token) || false }
        @request_user = user
        Time.zone = @request_user.time_zone unless @request_user.time_zone.blank?
      end
    else
      render nothing: true, status: :unauthorized
      false
    end
  end

  def is_authenticated?
    render(nothing: true, status: :unauthorized) unless @request_user
  end

  def is_self?
    render(nothing: true, status: :unauthorized) if @request_user.id != params[:id].to_i
  end

  private

  def set_raven_context
    Raven.user_context(id: request.headers['Authorization'])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
