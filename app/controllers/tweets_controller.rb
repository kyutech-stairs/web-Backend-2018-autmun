class TweetsController < ApplicationController
  def index
    tweets = Tweet.all
    render json: {status: 200, data: tweets}
  end

  def show
    tweet = Tweet.find(params[:id])
    render json: {status: 200, data: tweet}
  end

  def create
    tweet = Tweet.new(tweet_params)
    if tweet.save then
      render json: {status: 201, data: tweet}
    else
      render json: {status: 500, message: "Internal Server Error"}
    end
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
    params.require(:tweets).permit(:text, :user_id)
  end
end
