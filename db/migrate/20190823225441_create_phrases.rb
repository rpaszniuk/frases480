class CreatePhrases < ActiveRecord::Migration[6.0]
  def change
    create_table :phrases, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.text :phrase
      t.string :slug
      t.column :user_id, 'int unsigned', index: true
      t.column :category_id, 'int unsigned', index: true
      t.column :status, 'int(1) unsigned', default: 0

      t.timestamps
    end
  end
end
