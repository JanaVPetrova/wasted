class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.monetize :amount
      t.datetime :spend_at
      t.string :type
      t.references :user, foreign_key: true
      t.references :label, foreign_key: true
      t.references :day, foreign_key: true

      t.timestamps
    end

    add_index :expenses, :spend_at
    add_index :expenses, :type
  end
end
