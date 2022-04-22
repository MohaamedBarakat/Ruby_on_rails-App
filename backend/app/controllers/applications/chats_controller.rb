class Applications::ChatsController < ApplicationController
  def index
    begin
      chats = Chat.order(application_id: :asc)
      render json: { succ_messgae: 'chats retrived successfully', data: chats } , status: :ok
    rescue Exception => ex
      render json: {error:ex ,message: "unable to fetch chats"} , status: :unprocessable_entity
    end

  end

  def create
    begin
      CreateChatJob.perform_later(params[:application_token] ,params[:name])
      
      application = Application.where(token: params[:application_token]).first
      
      render json: { succ_messgae: 'Chat Created successfully', number_of_chats:  application.chat_count } , status: :created

    rescue Exception => ex
      render json: { error:ex, message: "unable to Create chat"} , status: :unprocessable_entity
    end
  end

  def show
    begin
      application = Application.find_by token: params[:application_token]
      if !application.id
        raise "token did not identfiy any application"
      end
      chat = Chat.where(application_id: application.id , number:params[:number]).first

      render json: { succ_message: 'Chat retrived successfully', data: chat.slice('name' , 'number')}, status: :ok
    rescue Exception => ex
      render json: { error:ex, message: "unable to Retrive chat"} , status: :unprocessable_entity
    end
  end

  def update
    begin
      UpdateChatJob.perform_now(params[:application_token],params[:number],params[:name])
      
      render json: { succ_message:'Update Chat name sent to queue successfully' } , status: :accepted
    rescue Exception => ex
      render json: { error:ex, message: "unable to update chat"} , status: :unprocessable_entity
    end
  end

end
