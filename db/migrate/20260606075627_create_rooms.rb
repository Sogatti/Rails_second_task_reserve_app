class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.string :hotel_name
      t.text :hotel_detail
      t.integer :hotel_rate
      t.string :address
      t.string :hotel_image

      t.timestamps
    end
  end
end
