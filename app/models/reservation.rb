class Reservation < ApplicationRecord
  # ===== アソシエーション（関連） =====
  # 予約は1人のユーザーに属する
  belongs_to :user
  # 予約は1つの施設に属する
  belongs_to :room

  # ===== バリデーション（入力チェック） =====
  # 必須項目
  validates :check_in_date, presence: true
  validates :check_out_date, presence: true
  validates :guest_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :total_price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # カスタムバリデーション: チェックアウトがチェックインより後か
  validate :check_out_after_check_in

  before_validation :calculate_total_price

  def check_out_after_check_in
    return if check_in_date.blank? || check_out_date.blank?

    if check_out_date <= check_in_date
      errors.add(:check_out_date, "はチェックイン日より後の日付を選択してください")
    end
  end

  validate :check_in_not_in_past

  def check_in_not_in_past
    return if check_in_date.blank?

    if check_in_date < Date.current
      errors.add(:check_in_date, "は本日からの日付を選択してください")
    end
  end

  # 合計金額 = 泊数 × 施設の1泊料金
  def calculate_total_price
    return if check_in_date.blank? || check_out_date.blank? ||room.blank?

    nights = (check_out_date - check_in_date).to_i
    self.total_price = nights * room.hotel_rate * guest_count.to_i
  end
end