class CreateListMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :list_messages do |t|
      t.string :name
      t.integer :type_mes, default: 0

      t.timestamps
    end
  end
end
