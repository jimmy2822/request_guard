class AddDefaultValueOnIssues < ActiveRecord::Migration[7.0]
  def change
    change_column_default :issues, :agree, from: 0, to: 1
    change_column_default :issues, :disagree, from: 0, to: 1
  end
end
