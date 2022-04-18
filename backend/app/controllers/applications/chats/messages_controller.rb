class Applications::Chats::MessagesController < ApplicationController
  def index
    render json:{message: 'hello from applications/chats/messages'}
  end

  def create
  end

  def update
  end
end
