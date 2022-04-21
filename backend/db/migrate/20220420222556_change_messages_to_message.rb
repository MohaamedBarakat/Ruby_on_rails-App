class ChangeMessagesToMessage < ActiveRecord::Migration[5.0]
  def change
    rename_table :message, :messages
  end
end
