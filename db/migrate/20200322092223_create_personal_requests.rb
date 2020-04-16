class CreatePersonalRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :personal_requests do |t|
      t.string :title
      t.text :reason
      t.integer :status, default: 0
      t.integer :project_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
