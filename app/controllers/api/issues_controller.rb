# frozen_string_literal: true

module Api
  class IssuesController < ApplicationController
    before_action :find_issue, only: [:agree, :disagree]

    def index
      issues = Issue.page(params[:page]).per(params[:per_page] || 10)

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
      redis.set("issue_#{params[:id]}_#{source_request_ip}", 'agree')

      render_success_response(data: { voted_result: 'agree' })
    end

    def disagree
      redis.set("issue_#{params[:id]}_#{source_request_ip}", 'disagree')

      render_success_response(data: { voted_result: 'disagree' })
    end

    private

    def find_issue
      @issue = Issue.find(params[:id])
    rescue
      render_error_response(code: 404, message: 'issue not found')
    end

    def issue_params
      params.permit(:name)
    end

    def redis
      @redis ||= Redis.new
    end
  end
end
