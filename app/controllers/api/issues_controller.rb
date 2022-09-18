# frozen_string_literal: true

module Api
  class IssuesController < ApplicationController
    def index
      issues = Issue.page(params[:page])

      data = {
        issues: issues,
        current_page: issues.current_page,
        total_pages: issues.total_pages
      }

      render_success_response(data: data)
    end

    def create
      issue = Issue.find_or_create_by!(issue_params)

      render_success_response(data: issue)
    end

    def agree
    end

    def disagree
    end

    private

    def issue_params
      params.permit(:name)
    end
  end
end
