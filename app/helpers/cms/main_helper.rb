module CMS::MainHelper
  def cms_page_title_tag
    if @page_title
      "#{@page_title} | #{t('config.cms.default_title')}"
    else
      t('config.cms.default_title')
    end
  end

  def cms_render_flash_messages
    flash_messages = []
    flash.each do |type, message|
      next if message.blank?

      case type.to_sym
      when :success
        type = 'alert-success'
      when :error
        type = 'alert-danger'
      when :alert
        type = 'alert-warning'
      when :notice
        type = 'alert-info'
      end
      Array(message).each do |message_text|
        unless message_text.blank?
          alert_content = %(<div class="alert #{type} alert-dismissable"><button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button> #{message_text.html_safe}</div>)
          flash_messages << alert_content
        end
      end
    end
    flash.clear
    flash_messages.join("\n").html_safe
  end

  def cms_render_breadcrumbs
    return if @breadcrumbs.blank?

    @breadcrumbs.insert(0, label: t('breadcrumbs.root'), url: cms_dashboard_path)
    html = %(<ol class="breadcrumb">)
    @breadcrumbs[0..-2].each do |breadcrumb|
      html += breadcrumb[:url].blank? ? %(<li class="breadcrumb-item#{(' featured' if breadcrumb[:featured])}">#{breadcrumb[:label].html_safe}</li>) : %(<li class="breadcrumb-item#{(' featured' if breadcrumb[:featured])}">#{link_to(breadcrumb[:label].html_safe, breadcrumb[:url], breadcrumb[:options])}</li>)
    end
    html += %(<li class="breadcrumb-item active"><strong>#{@breadcrumbs.last[:label]}</strong></li>)
    html += %(</ol>)
    html.html_safe
  end

  def will_paginate_cms(pages, options = {})
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

  def cms_yes_or_no(value)
    if value
      t('basic.yes')
    else
      t('basic.no')
    end
  end

  def cms_yes_or_no_label(value)
    if value
      %(<span class="badge badge-success">#{t('basic.yes').upcase}</span>).html_safe
    else
      %(<span class="badge badge-danger">#{t('basic.no').upcase}</span>).html_safe
    end
  end

  def cms_sub_menu_active_button(active, selected)
    active == selected ? 'btn-primary' : 'btn-default'
  end

  def cms_sub_menu_active_nav(active, selected)
    active == selected ? 'active' : ''
  end

  def cms_sub_menu_active_dropdown_nav(active_list, selected)
    active_list.include?(selected) ? 'highlighted' : ''
  end

  def cms_fa_icon(icon, options = {})
    %(<i class='fas fa-#{icon} #{options[:class]}'></i>).html_safe
  end

  def cms_object_status_label(object, options = {})
    print(object.class.name.underscore)
    print("asgasgsag")
    case object.status
    when 'draft', 'inactive', 'pending'
      %(<span class="badge badge-info #{options[:class]}">#{t("models.#{object.class.name.underscore}.status.#{object.status}").upcase}</span>).html_safe
    when 'active', 'finished'
      %(<span class="badge badge-success #{options[:class]}">#{t("models.#{object.class.name.underscore}.status.#{object.status}").upcase}</span>).html_safe
    when 'blocked', 'deleted', 'rejected'
      %(<span class="badge badge-danger #{options[:class]}">#{t("models.#{object.class.name.underscore}.status.#{object.status}").upcase}</span>).html_safe
    end
  end

  def cms_loader_for_link
    %(<span class='fas fa-cog fa-spin'></span>)
  end

  def cms_show_errors_for(object, attribute, options = {})
    return if object && !object.errors.blank? && !object.errors.key?(attribute) && object.errors.messages.key?(attribute)

    %(<div class="has-error #{options[:div_class]}"><p class="help-block">#{object.errors.messages[attribute].map(&:capitalize).to_sentence}</p></div>).html_safe
  end

  def cms_delete_action_label(object)
    object.deleted? ? 'Destruir' : 'Eliminar'
  end

  def cms_input_group(object, method, input_type, group_text, input_options = {})
    tag_builder = ActionView::Helpers::TagHelper::TagBuilder.new(nil)
    input_options[:class] = 'form-control' unless input_options.key?(:class)
    %(<div class="input-group#{' has-error' if object.errors.key?(method)}">
      <input type="text" value="#{object.send(method)}" name="#{object.class.name.underscore}[#{method}]" id="#{object.class.name.underscore}_#{method}" #{tag_builder.tag_options(input_options)}>
      <div class="input-group-append">
        <span class="input-group-text">#{group_text}</span>
      </div>
      #{cms_show_errors_for(object, method)}
    </div>).html_safe
  end
end
