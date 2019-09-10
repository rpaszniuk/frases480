module CMS::SidebarMenuHelper
  def cms_build_sidemenu(&_block)
    menu = {}
    panel_index = 0

    menu[panel_index] = { label: 'Dashboard', submenu: [], icon: 'home', url: :cms_dashboard, active: cms_active_controller?('dashboard') }

    if @current_user.access_profile.can?(:full_access, :users)
      panel_index += 1
      menu[panel_index] = { label: 'User', submenu: [], icon: 'users', active: cms_active_controller?('users') }
      menu[panel_index][:submenu] << { label: 'List', url: :cms_users }
      menu[panel_index][:submenu] << { label: 'Create', url: :new_cms_user }
    end

    if @current_user.access_profile.can?(:full_access, :access_profiles)
      panel_index += 1
      menu[panel_index] = { label: 'Access Profile', submenu: [], icon: 'key', active: cms_active_controller?('access_profiles') }
      menu[panel_index][:submenu] << { label: 'List', url: :cms_access_profiles }
      menu[panel_index][:submenu] << { label: 'Create', url: :new_cms_access_profile }
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
