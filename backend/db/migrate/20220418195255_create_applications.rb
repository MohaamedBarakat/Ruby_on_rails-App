class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.string :token , null:false
      t.integer :chat_count, default:0,null:false
      t.string :name, null:false

      t.timestamps
    end
    add_index :applications, :token, unique: true
  end
end
