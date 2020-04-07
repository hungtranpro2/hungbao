class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :start_day
      t.datetime :end_day
      t.string :description
      t.string :path_github
      t.integer :status
      t.integer :progess
      t.datetime :time_reality
      t.integer :estimated_time
      t.integer :priority
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
