class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ===== アソシエーション =====
  # 1人のユーザーは複数の予約を持つ
  has_many :reservations, dependent: :destroy
end