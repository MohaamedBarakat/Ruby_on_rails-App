class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.integer :number,null:false

      t.timestamps
    end
    add_index :chats, :number, unique: true
  end
end
