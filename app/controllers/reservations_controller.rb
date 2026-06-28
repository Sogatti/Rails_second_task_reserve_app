class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room_for_render, only: [:confirm, :execute_create]

  def index
    @reservations = current_user.reservations.includes(:room).order(check_in_date: :asc)
  end

  def confirm
    @reservation = current_user.reservations.build(reservation_params)

    if @reservation.valid?
      render :confirm
    else
      flash.now[:alert] = "予約内容に誤りがあります。"
      render "rooms/show", status: :unprocessable_entity
    end
  end

  def execute_create
    @reservation = current_user.reservations.build(reservation_params)

    if @reservation.save
      redirect_to reservations_path, notice: "予約が完了しました。"
    else
      flash.now[:alert] = "予約の確定に失敗しました。"
      render :confirm, status: :unprocessable_entity
    end
  end

  private

  def set_room_for_render
    room_id_from_params = params.dig(:reservation, :room_id)
    @room = Room.find(room_id_from_params) if room_id_from_params.present?
  rescue ActiveRecord::RecordNotFound
    redirect_to rooms_path, alert: "指定された施設が見つかりませんでした。"
  end

  def reservation_params
    params.require(:reservation).permit(:room_id, :check_in_date, :check_out_date, :guest_count)
  end
end