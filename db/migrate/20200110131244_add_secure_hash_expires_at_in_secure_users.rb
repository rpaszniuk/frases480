class AddSecureHashExpiresAtInSecureUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :secure_users, :secure_hash_expires_at, :datetime, after: :secure_hash
  end
end
