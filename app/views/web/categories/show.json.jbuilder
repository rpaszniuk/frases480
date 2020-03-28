json.extract! @category, :id, :description, :name
json.count @phrases_count
json.url web_show_category_url(@category.slug)
json.phrases(@phrases) do |phrase|
  json.extract! phrase, :id, :phrase
  json.url web_show_phrase_url(phrase.category.slug, phrase.slug)
end
