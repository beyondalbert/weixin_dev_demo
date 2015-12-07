class Admin::MpMenusController < ApplicationController
  before_filter :find_mp_menu, only: [:edit, :update, :destroy]
  def index
    @mp_menus = current_user.weixin_mp.mp_menus
    @parent_menu = current_user.weixin_mp.root_menus
  end

  def create
    @mp_menu = MpMenu.new(mp_menu_params)

    @mp_menu.weixin_mp_id = current_user.weixin_mp.id

    if @mp_menu.save
      redirect_to '/admin/mp_menus', flash: {success: "创建成功!"}
    end
  end

  def edit
    @parent_menu = current_user.weixin_mp.root_menus
  end

  def update
    @mp_menu.update(mp_menu_params)
    redirect_to '/admin/mp_menus', flash: {success: "更新成功!"}
  end

  def destroy
    @mp_menu.destroy
    redirect_to '/admin/mp_menus', flash: {success: "删除成功!"}
  end

  def push_to_remote
    @weixin_mp = current_user.weixin_mp
    menus = @weixin_mp.build_menus
    weixin_client = WeixinAuthorize::Client.new(@weixin_mp.app_id, @weixin_mp.app_secret)
    result = weixin_client.create_menu(menus)
    p "------------------------->"
    p result.full_message
    p result.result
    p menus
    if result.code == 0
      redirect_to '/admin/mp_menus', flash: {success: "set success!"}
    else
      redirect_to '/admin/mp_menus', flash: {alert: result.cn_msg}
    end
  rescue RestClient::RequestTimeout
    redirect_to '/admin/mp_menus', flash: {alert: "Time out!"}
  end

  private
  def mp_menu_params
    params.require(:mp_menu).permit(:name, :parent_id, :menu_type, :value, :is_show, :sort)
  end

  def find_mp_menu
    @mp_menu = MpMenu.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
