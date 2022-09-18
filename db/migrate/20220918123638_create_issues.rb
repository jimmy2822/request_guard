class CreateIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :issues do |t|
      t.string :name
      t.integer :agree
      t.integer :disagree

      t.timestamps
    end
  end
end
