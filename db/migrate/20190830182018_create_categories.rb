class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories, options: 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.string :name
      t.string :description
      t.string :slug
      t.column :status, 'int(1) unsigned', default: 0
      t.timestamps
    end
  end
end
