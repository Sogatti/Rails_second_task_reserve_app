class Room < ApplicationRecord
  mount_uploader :hotel_image, HotelImageUploader

  # ===== アソシエーション =====
  # 1つの施設は複数の予約を受け付けられる
  has_many :reservations, dependent: :destroy
end