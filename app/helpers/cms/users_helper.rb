module CMS::UsersHelper
  def show_avatar(user, layout = false)
    if user.avatar.attached?
      if layout
        image_tag(user.avatar.variant(resize: '30x30'), class: 'img-avatar')
      else
        link_to(image_tag(user.avatar, class: 'rounded-circle'), url_for(user.avatar), target: '_blank')
      end
    else
      image_tag('cms/default-avatar.svg', class: layout ? 'img-avatar' : 'rounded-circle')
    end
  end
end
