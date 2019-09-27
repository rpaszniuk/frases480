module WEB::MainHelper
  def web_page_title_tag
    if @page_title
      "#{@page_title} | #{t('config.cms.default_title')}"
    else
      t('config.cms.default_title')
    end
  end

  def web_render_page_metas
    code = ''
    case params[:controller]
    when 'web/main'
      case params[:action]
      when 'index'
        code << %(<meta name="description" content="Sitio web de frases de hasta 480 caracteres."/>\n)
        code << %(<meta name="og:url" content="#{web_root_url}"/>\n)
        code << %(<meta name="og:title" content="Frases 480"/>\n)
        code << %(<meta name="og:description" content="Sitio web de frases de hasta 480 caracteres."/>\n)
        # code << %(<meta name="og:image" content=""/>\n)
        code << %(<link rel="canonical" href="#{web_root_url}" />)
      when 'about'
        code << %(<meta name="description" content="Acerca de Frases 480"/>\n)
        code << %(<meta name="og:url" content="#{web_main_acerca_url}"/>\n)
        code << %(<meta name="og:title" content="Acerca de | Frases 480"/>\n)
        code << %(<meta name="og:description" content="Acerca de Frases 480"/>\n)
        # code << %(<meta name="og:image" content=""/>\n)
        code << %(<link rel="canonical" href="#{web_main_acerca_url}" />)
      end
    when 'web/phrases'
      case params[:action]
      when 'show'
        unless @phrase.nil?
          code << %(<meta name="description" content="#{ActionView::Base.full_sanitizer.sanitize(@phrase.phrase.truncate(140)).squish}"/>\n)
          code << %(<meta name="og:url" content="#{web_show_phrase_url(@phrase.category.slug, @phrase.slug)}"/>\n)
          code << %(<meta name="og:title" content="#{strip_tags(@phrase.title_for_share).tr('\"', '')}"/>\n)
          code << %(<meta name="og:description" content="#{ActionView::Base.full_sanitizer.sanitize(@phrase.phrase.truncate(140)).squish}"/>\n)
          # code << %(<meta name="og:image" content=""/>)
          code << %(<link rel="canonical" href="#{web_show_phrase_url(@phrase.category.slug, @phrase.slug)}"/>)
        end
      end
    when 'web/categories'
      case params[:action]
      when 'show'
        unless @category.nil?
          code << %(<meta name="description" content="#{ActionView::Base.full_sanitizer.sanitize(@category.description.truncate(140)).squish}"/>\n)
          code << %(<meta name="og:url" content="#{web_show_category_url(@category.slug)}"/>\n)
          code << %(<meta name="og:title" content="#{strip_tags(@category.title).tr('\"', '')}"/>\n)
          code << %(<meta name="og:description" content="#{ActionView::Base.full_sanitizer.sanitize(@category.description.truncate(140)).squish}"/>\n)
          # code << %(<meta name="og:image" content=""/>)
          code << %(<link rel="canonical" href="#{web_show_category_url(@category.slug)}"/>)
        end
      end
    end
    code.html_safe
  end

  def will_paginate_web(pages, options = {})
    default_options = {
      class: 'pagination',
      inner_window: 2,
      outer_window: 0,
      renderer: ApplicationHelper::WillBootstrapRenderer,
      previous_label: '&larr;',
      next_label: '&rarr;'
    }.merge(options)
    will_paginate(pages, default_options)
  end
end
