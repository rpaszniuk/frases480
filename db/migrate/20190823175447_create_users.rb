class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :auth_token, :string, limit: 22
      t.column :access_profile_id, 'int unsigned', index: true
      t.column :email, :string, limit: 255
      t.column :first_name, :string, limit: 100
      t.column :last_name, :string, limit: 100
      t.column :time_zone, :string, default: '', limit: 100
      t.column :is_super_user, :boolean, default: false
      t.column :status, 'int(1) unsigned', default: 0

      t.timestamps
    end
  end
end
