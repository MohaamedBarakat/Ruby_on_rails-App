class Applications::ChatsController < ApplicationController
  def index
    render json: {messgae: 'hello from nested chat controller'}
  end

  def create
  end

  def show
  end

  def update
  end
end
