json.(@category, :id, :name)
json.count @phrases_count
json.url web_category_url(@category)
json.phrases(@phrases) do |phrase|
  json.extract! phrase, :id, :phrase
  json.url web_phrase_url(phrase)
end
