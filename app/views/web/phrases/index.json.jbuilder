json.count @phrases_count
json.phrases(@phrases) do |phrase|
  json.extract! phrase, :id, :phrase, :category_id
  json.category_description phrase.category.name
  json.url web_show_phrase_path(phrase.category.slug, phrase.slug)
end
