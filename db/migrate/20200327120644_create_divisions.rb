class CreateDivisions < ActiveRecord::Migration[6.0]
  def change
    create_table :divisions do |t|
      t.string :name
      t.integer :is_project, default: false
      t.string :image
      t.timestamps
    end
  end
end
