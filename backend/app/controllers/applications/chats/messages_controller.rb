class Applications::Chats::MessagesController < ApplicationController
  def index
    begin
      application = Application.find_by token: params[:application_token]

      chat = Chat.where(application_id: application.id, number: params[:chat_number]).first

      messages = Message.select('number','body').where(chats_id: chat.id).order(created_at: :asc)

      render json:{ succ_message: 'Messages retrived succefully', messages: messages }, status: :ok

    rescue Exception => ex
      render json: { error:ex, message: "unable to Retrive messages"} , status: :unprocessable_entity
    end
  end

  def create
    begin
      application = Application.find_by token: params[:application_token]

      chat = Chat.where(application_id: application.id, number: params[:chat_number]).first

      maximum_message_num = Message.select('MAX(number) AS number').group(:chats_id).having(chats_id: chat.id).first
      if !maximum_message_num
        maximum_message_num = 1
      else
        maximum_message_num = maximum_message_num.number.to_i + 1
      end
      
      message = []
      Message.transaction do
        message = Message.new chats_id: chat.id, body: params[:body], number: maximum_message_num
        message.save!
      end
      render json:{ succ_message: 'Message created succefully', message: message}, status: :ok
      
    rescue Exception => ex
      render json: { error:ex, message: "unable to create message"} , status: :unprocessable_entity
    end
  end

  def update
    begin
      application = Application.find_by token: params[:application_token]

      chat = Chat.where(application_id: application.id, number: params[:chat_number]).first

      message = []
      Message.transaction do
        message = Message.where(chats_id: chat.id , number: params[:number]).first
        message.body = params[:body]
        message.save!
      end
      render json:{ succ_message: 'Message created succefully', message: message}, status: :ok

    rescue Exception => ex
      render json: { error:ex, message: "unable to update message"} , status: :unprocessable_entity

    end
  end
end
