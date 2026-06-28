class RoomsController < ApplicationController
  def index
    @room = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room =
Room.new(params.require(:room).permit(:hotel_name, :hotel_detail, :hotel_rate, :address, :hotel_image))
    if @room.save
      flash[:notice] = "施設の新規登録が完了しました"
      redirect_to :rooms_index
    else
      render "new", status:
:unprocessable_entity
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(params.require(:room).permit(:hotel_image, :hotel_name, :address, :hotel_rate, :hotel_detail))
      flash[:notice] = "ユーザーが「#{@room.id}」の情報を更新しました"
      redirect_to :rooms
    else
      render "edit" , status: :unprocessable_entity
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    redirect_to rooms_path, notice: "削除しました", status: :see_other
  end
end
