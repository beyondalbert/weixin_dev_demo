class EventReply < ActiveRecord::Base
  belongs_to :weixin_mp

  validates :key, uniqueness: true
end
