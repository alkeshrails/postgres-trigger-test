class InvoiceItem < ApplicationRecord
  has_many :user_changes

  trigger.after(:update).of(:amount) do
    "INSERT INTO user_changes(id, old_amount, new_amount,  created_at, updated_at) VALUES(NEW.id, OLD.amount, NEW.amount, timezone('utc', now()), timezone('utc', now()));"
  end
end
