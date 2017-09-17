class AddAssistentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :assistent, :string
  end
end
