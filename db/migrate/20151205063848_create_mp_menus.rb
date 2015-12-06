class CreateMpMenus < ActiveRecord::Migration
  def change
    create_table :mp_menus do |t|
      t.string :name
      t.integer :weixin_mp_id
      t.integer :parent_id
      t.string :key
      t.string :url
      t.string :is_show
      t.integer :sort

      t.timestamps
    end
  end
end
