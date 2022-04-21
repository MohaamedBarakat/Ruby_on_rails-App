class ChangeNumberInChats < ActiveRecord::Migration[5.0]
  change_column :chats, :number, :bigint, null: false, unique: false
  remove_index :chats, name: "index_chats_on_number"
  def change
  end
end
