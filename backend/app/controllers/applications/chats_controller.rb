class Applications::ChatsController < ApplicationController
  def index
    begin
      chats = Chat.order(application_id: :asc)
      render json: { succ_messgae: 'chats retrived Succecfully', data: chats } , status: :ok
    rescue Exception => ex
      render json: {error:ex ,message: "unable to fetch chats"} , status: :unprocessable_entity
    end

  end

  def create
    begin
      application = []
      Application.transaction do
        Chat.transaction do
          application = Application.find_by token: params[:application_token] 

          num_chats = Chat.where(application_id: application.id).count
          num_chats+=1

          chat = Chat.new application_id: application.id, number: num_chats,name: params[:name]

          application.chat_count = Chat.where(application_id: application.id).count + 1

          chat.save!
          application.save!
        end
      end
      render json: { succ_messgae: 'Chat Created Succecfully', number_of_chats:  application.chat_count } , status: :created

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

      render json: { succ_message: 'Chat retrived Succecfully', data: chat.slice('name' , 'number')}, status: :ok
    rescue Exception => ex
      render json: { error:ex, message: "unable to Retrive chat"} , status: :unprocessable_entity
    end
  end

  def update
    begin
      chat = []
      Chat.transaction do
        application = Application.find_by token: params[:application_token]
        if !application.id
          raise "token did not identfiy any application"
        end
        chat = Chat.where( application_id: application.id , number: params[:number]).first
        chat.name = params[:name]
        chat.save!
      end
      render json: { succ_message:'Chat name updated Succecfully', data: chat.slice('name' , 'number') } , status: :accepted
    rescue Exception => ex
      render json: { error:ex, message: "unable to update chat"} , status: :unprocessable_entity
    end
  end
end
