xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do
  xml.channel do
    xml.title 'Frases 480'
    xml.author 'Frases 480'
    xml.description 'Sitio web de frases de hasta 480 caracteres.'
    xml.link web_root_url
    xml.language 'es'

    @phrases.each do |phrase|
      xml.item do
        xml.title phrase.title
        xml.author 'Frases 480'
        xml.pubDate phrase.created_at.to_s(:rfc822)
        xml.link web_show_phrase_url(phrase.category.slug, phrase.slug)
        xml.guid phrase.id
        xml.description phrase.phrase
      end
    end
  end
end
