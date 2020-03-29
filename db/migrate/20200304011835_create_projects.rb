class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :division_id
      t.string :description

      t.timestamps
    end
  end
end
