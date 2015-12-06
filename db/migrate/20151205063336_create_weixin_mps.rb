class CreateWeixinMps < ActiveRecord::Migration
  def change
    create_table :weixin_mps do |t|
      t.string :name
      t.string :note
      t.string :weixin_secret_key
      t.string :weixin_token
      t.string :app_id
      t.string :app_secret
      t.integer :user_id

      t.timestamps
    end
  end
end
