class User < ApplicationRecord
  mount_uploader :user_image, UserImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ===== アソシエーション =====
  # 1人のユーザーは複数の予約を持つ
  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
end