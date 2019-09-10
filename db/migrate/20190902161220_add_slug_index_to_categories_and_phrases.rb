class AddSlugIndexToCategoriesAndPhrases < ActiveRecord::Migration[6.0]
  def change
    add_index :phrases, :slug
    add_index :categories, :slug
  end
end
