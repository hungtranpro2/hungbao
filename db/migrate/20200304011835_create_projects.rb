class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :document_link
      t.boolean :active, default: true
      t.string :client_company
      t.timestamps
    end
  end
end
