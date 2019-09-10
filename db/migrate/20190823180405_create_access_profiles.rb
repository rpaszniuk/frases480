class CreateAccessProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :access_profiles, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.column :name, :string, limit: 50
      t.column :status, 'INT(1) UNSIGNED', default: 0
      t.column :permissions, :text
      t.column :is_super_profile, :boolean, default: false

      t.timestamps
    end
  end
end
