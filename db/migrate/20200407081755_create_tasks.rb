class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.datetime :start_time
      t.datetime :end_time
      t.text :description
      t.string :path_github
      t.integer :percent, default: 0
      t.integer :parent_id
      t.boolean :parent_task, default: false
      t.integer :progess
      t.datetime :reality_time
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
