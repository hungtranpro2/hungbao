class CreatePersonalRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :personal_requests do |t|
      t.integer :request_type, default: 0
      t.datetime :time_from
      t.datetime :time_to
      t.text :reason
      t.integer :status, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
