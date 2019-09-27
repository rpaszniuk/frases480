json.array!(@categories) do |category|
  json.extract! category, :id, :name, :description
  json.url web_show_category_path(category.slug)
end
