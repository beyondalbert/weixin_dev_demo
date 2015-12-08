class WeixinMp < ActiveRecord::Base
  include WeixinRailsMiddleware::AutoGenerateWeixinTokenSecretKey

  belongs_to :user
  has_many :mp_menus
  has_many :event_replies

  def root_menus
    MpMenu.where(weixin_mp_id: self.id, parent_id: nil)
  end

  def build_menus
    Jbuilder.encode do |json|
      json.button (root_menus) do |root_menu|
        json.name root_menu.name
        if root_menu.has_sub_menu?
          json.sub_button(root_menu.sub_menus) do |sub_menu|
            json.name sub_menu.name
            json.type sub_menu.menu_type
            sub_menu.button_type(json) 
          end
        else
          json.type root_menu.menu_type
          root_menu.button_type(json)
        end
      end
    end
  end
end
