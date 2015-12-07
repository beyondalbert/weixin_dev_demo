class Admin::WeixinMpsController < AdminController

  def create
    @weixin_mp = WeixinMp.new(weixin_mp_params)
    @weixin_mp.user_id = current_user.id
    if @weixin_mp.save
      redirect_to "/admin/dashboard/index", flash: {success: "创建成功！"}
    else
    end
  end

  private
  def weixin_mp_params
    params.require(:weixin_mp).permit(:name, :note, :app_id, :app_secret)
  end
end
