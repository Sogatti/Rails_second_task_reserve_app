class RoomsController < ApplicationController

before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      flash[:notice] = "施設の新規登録が完了しました"
      redirect_to rooms_path
    else
      render "new", status: :unprocessable_entity
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
  
  def search
    @rooms = Room.all
    
    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    if params[:keyword].present?
      keyword = params[:keyword]
    @rooms = @rooms.where("hotel_name LIKE ? OR hotel_detail LIKE ?", "%#{keyword}%", "%#{keyword}%")
    end
  end


private

 def room_params
  params.require(:room).permit(:hotel_name, :hotel_detail, :hotel_rate, :address, :hotel_image)
 end
end
