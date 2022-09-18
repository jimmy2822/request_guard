# frozen_string_literal: true

class ApiController < ApplicationController
  def hello
    render_success_response(data: 'world')
  end
end
