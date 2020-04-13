class CreateProjectRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :project_requests do |t|
      t.text :description
      t.string :document_link
      t.string :title
      t.string :client_company
      t.string :project_leader
      t.references :project, foreign_key: true
      t.references :division, foreign_key: true

      t.timestamps
    end
  end
end
