class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.integer :object_id
      t.string :object_type
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :status, default: 0
      t.integer :progress, default: 0
      t.text :content
      t.boolean :seen, default: false

      t.timestamps
    end
  end
end
