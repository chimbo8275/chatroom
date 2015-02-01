class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :room_id
      t.integer :author_id
      t.text :body

      t.timestamps null: false
    end
  end
end
