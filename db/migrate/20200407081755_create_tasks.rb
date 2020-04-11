class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :start_time
      t.date :end_time
      t.text :description
      t.string :path_github
      t.integer :lock, default: 0
      t.boolean :active, default: true
      t.integer :parent_id
      t.boolean :parent_task, default: false
      t.integer :progress
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
