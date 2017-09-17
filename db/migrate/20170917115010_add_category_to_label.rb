class AddCategoryToLabel < ActiveRecord::Migration[5.1]
  def change
    add_reference :labels, :category, foreign_key: true
  end
end
