class CreateIncomes < ActiveRecord::Migration[5.1]
  def change
    create_table :incomes do |t|
      t.references :user, foreign_key: true
      t.references :label, foreign_key: true
      t.monetize :amount
      t.datetime :received_at
      t.datetime :spend_till

      t.timestamps
    end

    add_index :incomes, [:received_at, :spend_till]
  end
end
