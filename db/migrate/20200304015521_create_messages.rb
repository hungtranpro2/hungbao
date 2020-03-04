class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :to_id
      t.integer :rep_id
      t.references :list_message, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
