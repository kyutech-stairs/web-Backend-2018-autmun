class Users::TweetsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    tweets = user.tweets.all
    render json: {status: 200, data: tweets}
  end
end
