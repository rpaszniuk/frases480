module CMS::SidebarMenuHelper
  def cms_build_sidemenu(&_block)
    menu = {}
    panel_index = 0

    menu[panel_index] = { label: 'Escritorio', submenu: [], icon: 'home', url: :cms_dashboard, active: cms_active_controller?('dashboard') }

    panel_index += 1
    menu[panel_index] = { label: 'Frases', submenu: [], icon: 'book', active: cms_active_controller?('phrases/') }
    menu[panel_index][:submenu] << { label: 'Listar', url: :cms_phrases }
    menu[panel_index][:submenu] << { label: 'Crear', url: :new_cms_phrase }

    if @current_user.access_profile.can?(:full_access, :categories)
      panel_index += 1
      menu[panel_index] = { label: 'Categorías', submenu: [], icon: 'tasks', active: cms_active_controller?('categories') }
      menu[panel_index][:submenu] << { label: 'Listar', url: :cms_categories }
      menu[panel_index][:submenu] << { label: 'Crear', url: :new_cms_category }
    end

    if @current_user.access_profile.can?(:full_access, :users)
      panel_index += 1
      menu[panel_index] = { label: 'Usuarios', submenu: [], icon: 'users', active: cms_active_controller?('users') }
      menu[panel_index][:submenu] << { label: 'Listar', url: :cms_users }
      menu[panel_index][:submenu] << { label: 'Crear', url: :new_cms_user }
    end

    if @current_user.access_profile.can?(:full_access, :access_profiles)
      panel_index += 1
      menu[panel_index] = { label: 'Perfiles de Acceso', submenu: [], icon: 'key', active: cms_active_controller?('access_profiles') }
      menu[panel_index][:submenu] << { label: 'Listar', url: :cms_access_profiles }
      menu[panel_index][:submenu] << { label: 'Crear', url: :new_cms_access_profile }
    end

    menu.each_value do |group|
      yield(group)
    end
  end

  def cms_active_controller?(controller_name)
    if controller_name.is_a?(String)
      params[:controller] == controller_name
    else
      controller_name.include?(params[:controller])
    end
  end

  def cms_active_action?(action_name)
    if action_name.is_a?(String)
      params[:action] == action_name
    else
      action_name.include?(params[:action])
    end
  end
end
