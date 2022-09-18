# frozen_string_literal: true

class ApiController < ApplicationController
  def hello
    render json: 'world'
  end
end
