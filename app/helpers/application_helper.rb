module ApplicationHelper
  def options_from_translation_for_select(path)
    t(path).collect{|k, v| [v, k]}
  end
  
  class WillBootstrapRenderer < ::WillPaginate::ActionView::LinkRenderer
    protected

    def html_container(html)
      tag(:ul, html, container_attributes) 
    end

    def page_number(page)
      tag :li, link(page, page, rel: rel_value(page), page: page, class: 'page-link'), class: (page == current_page ? 'page-item active' : 'page-item')
    end

    def gap
      tag :li, link(super, '#'), class: 'page-item'
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#', page: page, class: 'page-link'), class: [classname[0..3], classname, (page ? 'page-item' : 'page-item disabled')].join(' ')
    end
  end
end
