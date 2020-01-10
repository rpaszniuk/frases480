class Postman
  include ActionView::Helpers::NumberHelper

  attr_accessor :sendgrid, :error

  def initialize(_options = {})
    @sendgrid = SendGrid::API.new(api_key: Newfrases480::Application.credentials.sendgrid[:api_key])
  end

  def send_password_recovery_email(data = {})
    @mail = SendGrid::Mail.new

    @mail.from = SendGrid::Email.new(email: Newfrases480::Application.credentials.emails[:no_reply], name: Newfrases480::Application.credentials.name)

    # SANDBOX?
    if Newfrases480::Application.credentials.sendgrid[:sandbox]
      mail_settings = SendGrid::MailSettings.new
      mail_settings.sandbox_mode = SendGrid::SandBoxMode.new(enable: true)
      @mail.mail_settings = mail_settings
    end

    personalization = SendGrid::Personalization.new
    personalization.add_to(SendGrid::Email.new(email: data[:email]))
    personalization.add_substitution(
      SendGrid::Substitution.new(
        key: '###RESET_PASSWORD###',
        value: Rails.application.routes.url_helpers.cms_sessions_recover_password_url(secure_hash: data[:secure_hash], host: Newfrases480::Application.credentials.cms_domain, protocol: 'https')
      )
    )
    personalization.add_substitution(SendGrid::Substitution.new(key: '###CURRENT_YEAR###', value: Time.current.year.to_s))
    @mail.add_personalization(personalization)
    @mail.template_id = Newfrases480::Application.credentials.sendgrid[:templates][:password_recovery]
    response = @sendgrid.client.mail._('send').post(request_body: @mail.to_json)

    case response.status_code
    when /[2][0-9]{2,3}/
      Rails.logger.debug "SENGRID RESULT: #{response.body} \nHEADERS: #{response.headers}"
      true
    when /[4][0-9]{2,3}/
      Rails.logger.debug "SENGRID 4XX RESPONSE:\n Status: #{response.status_code} \nHEADERS: #{response.headers} \nBody: #{response.body}"
      false
    when /[5][0-9]{2,3}/
      Rails.logger.debug "SENGRID 5XX RESPONSE:\n Status: #{response.status_code} \nHEADERS: #{response.headers} \nBody: #{response.body}"
      false
    end
  rescue StandardError => e
    Rails.logger.error "An error occurred: #{e.class} - #{e.message}"
  end
  false
end
