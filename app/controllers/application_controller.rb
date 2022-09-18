# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :check_request_rate_limit
  rescue_from RuntimeError do |e|
    Rails.logger.error("Error #{e} is occurring")

    render_error_response(code: 500, message: 'Something went wrong! we are working on it!')
  end

  def check_request_rate_limit
    redis = Redis.new

    source_request_ip = request.env['REMOTE_ADDR']
    source_ip_counter = redis.incr(source_request_ip)
    redis.expire(source_request_ip, 60) if source_ip_counter == 1

    render_error_response(code: 429, message: 'REQUEST RATE LIMIT REACHED') if source_ip_counter > 60
  end

  def render_error_response(code:, message:)
    render json: { status_code: code, error_message: message }
  end

  def render_success_response(data:, code: 200, message: 'success')
    render json: { status_code: code, data: data, message: message }
  end
end
