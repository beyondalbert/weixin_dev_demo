class WeixinMp < ActiveRecord::Base
  include WeixinRailsMiddleware::AutoGenerateWeixinTokenSecretKey

  belongs_to :user
end
