class Admin::WeixinMpsController < AdminController
  def create
    @weixin_mp = WeixinMp.new(weixin_mp_params)
    @weixin_mp.user_id = current_user.id
    if @weixin_mp.save
      redirect_to "/admin/dashboard/index", flash: {success: "创建成功！"}
    else
    end
  end

  def update
    @weixin_mp = WeixinMp.find(params[:id])
    @weixin_mp.update(weixin_mp_params)
    redirect_to "/admin/dashboard/index", flash: {success: "更新成功！"}
  end

  private
  def weixin_mp_params
    params.require(:weixin_mp).permit(:name, :note, :app_id, :app_secret)
  end
end
