class Admin::DashboardController < AdminController
  def index
    @weixin_mp = current_user.weixin_mp
  end
end
