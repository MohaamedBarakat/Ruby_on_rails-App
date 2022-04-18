class AddApplicationRefToChat < ActiveRecord::Migration[5.0]
  def change
    add_reference :chats, :application, foreign_key: true,null:false
  end
end
