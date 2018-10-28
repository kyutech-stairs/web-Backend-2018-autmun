class UsersController < ApplicationController
  def index
    users = User.all
    render json: {status: 200, data: users}
  end

  def show
    user = User.find(params[:id])
    render json: {status: 200, data: user}
  end

  def create
    # 面倒
    # user = User.new(name: params[:name], bio: params[:bio], localtion: params[:localtion], website: params[:website])
    user = User.new(user_params)    
    if user.save then
      render json: {status: 201, data: user}
    else 
      render json: {status: 500, message: 'Internal Server Error'}
    end
  end
  
  def update
    user = User.find(params[:id]) 
    if user.update_attributes(user_params)
      render json: {status: 200, data: user}
    else
      render json: {status: 500, message: 'Internal Server Error'}
    end
  end

  def destroy
    if User.find(params[:id]).destroy then
      render json: {status: 200, message: 'success'}
    else
      render json: {status: 500, message: 'Internal Server Error'}
    end
  end


  private 
  def user_params
    params.require(:user).permit(:name, :bio, :location, :website)
  end
end
