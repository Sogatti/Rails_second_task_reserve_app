class Room < ApplicationRecord
  mount_uploader :hotel_image, HotelImageUploader

  # ===== アソシエーション =====
  # 1つの施設は複数の予約を受け付けられる
  belongs_to :user
  has_many :reservations, dependent: :destroy
  validates :hotel_name, :hotel_detail, :address, presence: true
  validates :hotel_rate, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end