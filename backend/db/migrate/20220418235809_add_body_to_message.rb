class AddBodyToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :body, :string, null: false
  end
end
