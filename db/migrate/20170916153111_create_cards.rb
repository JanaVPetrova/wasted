class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :external_id
      t.string :kind
      t.string :payment_system
      t.datetime :synced_at

      t.timestamps
    end
  end
end
