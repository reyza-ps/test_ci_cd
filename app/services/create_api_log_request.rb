class CreateApiLogRequest
  attr_accessor :extras, :current_application, :headers, :token, :args

  def initialize(args = {})
    @args = args
    @extras = args.fetch('extras', {})
    @headers = args['request']['headers']
    @token = nil
    @current_application = nil
  end

  def perform
    if args['type'].to_s == 'incoming'
      if headers['HTTP_AUTHORIZATION'].present? && headers['HTTP_AUTHORIZATION'].include?('Token')
        token = headers['HTTP_AUTHORIZATION'].split(' ').last
      end
      credential = Credential.find_by token: token if token
    elsif args['type'].to_s == 'outgoing'
      if headers['Authorization'].present? && headers['Authorization'].include?('Token')
        token = headers['Authorization'].split(' ').last
      end
      credential = Credential.find_by(token_b: token) if token
    end

    if credential
      access_token = Partner::AccessToken.find_by ocpi_credentials_id: credential.id
      current_application = access_token.application if access_token
    end

    if args['type'] == 'outgoing' && credential.nil? && token
      current_application = Partner::Application.find_by(credentials_token_a: token)
    end

    data = {}
    data[:endpoint]    = args['request']['path']
    data[:environment] = fetch_current_application.try(&:environment)
    data[:description] = "OCPI API #{args['type']} request #{http_method(args)}"
    data[:http_method] = http_method(args)
    # request
    data[:request_params] = args['request']['params']
    data[:request_headers] = headers
    # response
    data[:response_body] = args['type'].to_s == 'incoming' ? {} : args['response']['body']
    data[:status_code] = args['response']['status']

    data[:oauth_application_id] = fetch_current_application.try(&:id) || current_application&.id
    data[:request_type] = args['type']
    Partner::ApiRequestLog.create!(data)
  end

  private

  def fetch_current_application
    return current_application if current_application.present?

    OpenStruct.new(@extras) if extras.any?
  end

  def http_method(args)
    return args['request']['headers']['REQUEST_METHOD'] if args['type'] == 'incoming'
    return args['http_method'] if args['type'] == 'outgoing'

    'UNKWOWN'
  end
end
