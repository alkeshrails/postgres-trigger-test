# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggerInvoiceItemsUpdate < ActiveRecord::Migration[7.0]
  def up
    create_trigger("invoice_items_after_update_of_amount_row_tr", :generated => true, :compatibility => 7).
        on("invoice_items").
        after(:update).
        of(:amount) do
      "INSERT INTO user_changes(id, old_amount, new_amount,  created_at, updated_at)
       VALUES(NEW.id, OLD.amount, NEW.amount, timezone('utc', now()),
        timezone('utc', now())) ON CONFLICT (id) DO UPDATE  SET created_at = excluded.created_at, 
        updated_at = excluded.updated_at,
        old_amount = excluded.old_amount, new_amount = excluded.new_amount;"
    end
  end

  def down
    drop_trigger("invoice_items_after_update_of_amount_row_tr", "invoice_items", :generated => true)
  end
end