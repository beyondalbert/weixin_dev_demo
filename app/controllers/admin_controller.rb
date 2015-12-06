class AdminController < ApplicationController
  # 如有必要，可以设置admin页面单独的layout
  # layout 'admin'
  before_filter :require_admin
end
