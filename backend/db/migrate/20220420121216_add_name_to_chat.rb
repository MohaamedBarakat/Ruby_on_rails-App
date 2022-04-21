class AddNameToChat < ActiveRecord::Migration[5.0]
  def change
    add_column :chats, :name, :string, default:'chat name', null:false
  end
end
