class CreateApprovalRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :approval_requests do |t|
      t.integer :status, default: 0
      t.integer :send_for, default: 0
      t.integer :personal_request_id
      t.integer :division_id

      t.timestamps
    end
  end
end
