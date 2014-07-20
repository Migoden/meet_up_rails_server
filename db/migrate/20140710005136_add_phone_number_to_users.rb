class AddPhoneNumberToUsers < ActiveRecord::Migration

  def change
    add_column :users, :phone, :integer
    add_index :users, :phone
  end
end
