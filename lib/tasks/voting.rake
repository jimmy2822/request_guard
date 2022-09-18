# frozen_string_literal: true

desc 'Handling issue voting results'
namespace :voting do
  task :persist_result, [:issue_id] => :environment do |_, args|
    issue_id = args.issue_id.to_i

    redis = Redis.new
    target_issue_voting_keys = redis.keys("issue_#{issue_id}_*")
    voting_results = target_issue_voting_keys.map { |key| redis.get(key) }
    agreed_result_total = voting_results.filter { |result| result == 'agree' }.size
    disagreed_result_total = voting_results.filter { |result| result == 'disagree' }.size

    issue = Issue.find(issue_id)
    issue.update(agree: issue.agree + agreed_result_total,
                 disagree: issue.disagree + disagreed_result_total)
    target_issue_voting_keys.map { |key| redis.del(key) }
  end
end
