class CreateDays < ActiveRecord::Migration[5.1]
  def change
    create_table :days do |t|
      t.date :date
      t.monetize :limit_amount
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :days, [:date, :user_id], unique: true
  end
end
