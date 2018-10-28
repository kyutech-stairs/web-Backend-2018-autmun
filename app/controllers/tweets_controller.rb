class TweetsController < ApplicationController
  def index
    tweets = Tweet.all
    render json: {status: 200, data: tweets}
  end

  def show

  end

  def create
  end

  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.destroy then
      render json: {status: 200, message: 'OK'}
    else
      render json: {status: 500, message: 'Internal Server Error'}
    end
  end


  private 
  def tweet_params
    params.require(:tweets).permit(:tweets, :user_id)
  end
end
