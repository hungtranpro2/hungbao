class CreateMyWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :my_works do |t|
      t.string :title
      t.date :start_time
      t.date :end_time
      t.text :description

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
