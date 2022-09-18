class AddDefaultValueOnIssues < ActiveRecord::Migration[7.0]
  def change
    change_column_default :issues, :agree, from: nil, to: 0
    change_column_default :issues, :disagree, from: nil, to: 0
  end
end
