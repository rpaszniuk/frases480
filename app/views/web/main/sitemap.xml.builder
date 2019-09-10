xml.instruct!
xml.urlset 'xmlns': 'https://www.sitemaps.org/schemas/sitemap/0.9' do
  xml.url do
    xml.loc web_root_url
    xml.loc web_acerca_url
    xml.priority 1.0
  end

  @categories.each do |category|
    xml.url do
      xml.loc web_show_category_url(category.slug)
      xml.lastmod category.updated_at.to_date
      xml.priority 0.9
    end
  end

  @phrases.each do |phrase|
    xml.url do
      xml.loc web_show_phrase_url(phrase.category.slug, phrase.slug)
      xml.lastmod phrase.updated_at.to_date
      xml.priority 0.9
    end
  end
end
