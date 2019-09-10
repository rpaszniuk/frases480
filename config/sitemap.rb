# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://www.frases480.com'
# SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps'

SitemapGenerator::Sitemap.create do
  add web_root_path, changefreq: 'daily', priority: 1.0
  add web_main_acerca_path, changefreq: 'weekly'

  Category.all.each do |category|
    add web_show_category_path(category.slug), lastmod: category.updated_at, priority: 0.9
  end

  Phrase.includes(:category).each do |phrase|
    add web_show_phrase_path(phrase.category.slug, phrase.slug), lastmod: phrase.updated_at, priority: 0.7
  end
end
