# frozen_string_literal: true

module Api
  class IssuesController < ApplicationController
    def index
      render_success_response(data: 'listing issues')
    end

    def create
    end

    def agree
    end

    def disagree
    end
  end
end
