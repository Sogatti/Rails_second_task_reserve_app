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
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
