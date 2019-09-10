json.array!(@results) do |phrase|
  json.extract! phrase, :id, :phrase , :category_id
  json.category_description phrase.category.description
  json.url web_phrase_url(phrase)
end
