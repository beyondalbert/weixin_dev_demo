class MpMenu < ActiveRecord::Base
  belongs_to :weixin_mp

  has_many :sub_menus, ->{where(is_show: true).order("sort").limit(5)}, class_name: "MpMenu", foreign_key: :parent_id


  def has_sub_menu?
    sub_menus.present?
  end

  def parent_menu
    MpMenu.find_by_id(self.parent_id)
  end

  def button_type(jbuilder)
    menu_type == "view" ? (jbuilder.url value) : (jbuilder.key value)
  end

  # def sub_menus
  #   MpMenu.where(is_show: true, parent_id: self.id, weixin_mp_id: self.weixin_mp_id).order('sort').limit(5)
  # end
end
