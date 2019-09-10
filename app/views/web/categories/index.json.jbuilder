json.array!(@categories) do |category|
  json.extract! category, :id, :description
  json.url web_category_url(category)
end
