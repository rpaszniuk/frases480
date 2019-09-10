class CreateSecureUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :secure_users, id: false, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :user_id, 'int unsigned', index: true
      t.column :password, :string, limit: 128, null: false
      t.column :password_salt, :string, limit: 40, null: false
      t.column :secure_hash, :string, limit: 40, null: false

      t.timestamps
    end
    execute 'ALTER TABLE secure_users ADD PRIMARY KEY (user_id)'
  end
end
