module APIAccessControl
  extend ActiveSupport::Concern
  include ActionController::HttpAuthentication::Token::ControllerMethods

  included do
    # skip_before_action :verify_authenticity_token
    # respond_to :json
    wrap_parameters format: []
    attr_reader :request_user

    before_action :authenticate
  end

  def authenticate
    if request.headers['X-Application-Secret'] == Newfrases480::Application.credentials.app_secret
      if (user = authenticate_with_http_token { |token, _options| User.find_by(auth_token: token) || false })
        @request_user = user
        Time.zone = @request_user.time_zone unless @request_user.time_zone.blank?
        return true
      end
    else
      head :unauthorized
    end
    false
  end

  def authenticated?
    head :unauthorized unless @request_user
  end

  def self?
    head :unauthorized if @request_user.id != params[:id].to_i
  end
end
