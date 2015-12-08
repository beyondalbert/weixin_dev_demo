class CreateEventReplies < ActiveRecord::Migration
  def change
    create_table :event_replies do |t|
      t.string :name
      t.string :key
      t.text :value
      t.integer :weixin_mp_id

      t.timestamps
    end
  end
end
