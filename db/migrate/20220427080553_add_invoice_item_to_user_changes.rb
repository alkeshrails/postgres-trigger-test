class AddInvoiceItemToUserChanges < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_changes, :invoice_item, null: false, foreign_key: true
  end
end
