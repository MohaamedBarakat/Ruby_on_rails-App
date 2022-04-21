class ChangeNumberInMessages < ActiveRecord::Migration[5.0]
  def change
    change_column :messages , :number, :bigint, null:false, unique: false
  end
end
