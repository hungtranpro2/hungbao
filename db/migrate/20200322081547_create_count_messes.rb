class CreateCountMesses < ActiveRecord::Migration[6.0]
  def change
    create_table :count_messes do |t|
      t.count_mess :integer
      t.references :list_message, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
