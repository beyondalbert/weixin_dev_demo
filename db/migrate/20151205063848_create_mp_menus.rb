class CreateMpMenus < ActiveRecord::Migration
  def change
    create_table :mp_menus do |t|
      t.string :name
      t.integer :weixin_mp_id
      t.integer :parent_id
      t.string :menu_type
      t.string :value
      t.boolean :is_show
      t.integer :sort

      t.timestamps
    end
  end
end
