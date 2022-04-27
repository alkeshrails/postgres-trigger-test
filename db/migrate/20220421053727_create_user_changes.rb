class CreateUserChanges < ActiveRecord::Migration[7.0]
  def change
    create_table :user_changes do |t|
      t.integer :old_amount
      t.integer :new_amount
      t.integer :job_status, default: 0

      t.timestamps
    end
  end
end
