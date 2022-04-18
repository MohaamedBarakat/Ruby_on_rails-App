class AddChatToMessage < ActiveRecord::Migration[5.0]
  def change
    add_reference :messages, :chats, foreign_key: true , null:false
  end
end
