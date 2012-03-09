class AddRecipientToEarmarks < ActiveRecord::Migration
  def change
    add_column :earmarks, :recipient, :text
  end
end
