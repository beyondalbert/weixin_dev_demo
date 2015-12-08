class Admin::EventRepliesController < AdminController
  before_filter :find_event_reply, only: [:edit, :update, :destroy]

  def index
    @event_replies = current_user.weixin_mp.event_replies

  end

  def create
    @event_reply = EventReply.new(event_reply_params)
    @event_reply.weixin_mp_id = current_user.weixin_mp.id

    if @event_reply.save
      redirect_to '/admin/event_replies', flash: {success: "创建成功!"}
    else
      redirect_to '/admin/event_replies', flash: {alert: "创建失败！"}
    end
  end

  def edit
  end

  def update
    @event_reply.update(event_reply_params)
    redirect_to '/admin/event_replies', flash: {success: "更新成功!"}
  end

  def destroy
    @event_reply.destroy
    redirect_to '/admin/event_replies', flash: {success: "删除成功!"}
  end

  private
  def event_reply_params
    params.require(:event_reply).permit(:name, :key, :value)
  end

  def find_event_reply
    @event_reply = EventReply.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
