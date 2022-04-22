class Applications::Chats::MessagesController < ApplicationController
  def index
    begin
      application = Application.find_by token: params[:application_token]

      chat = Chat.where(application_id: application.id, number: params[:chat_number]).first

      messages = Message.select('number','body').where(chats_id: chat.id).order(created_at: :asc)

      render json:{ succ_message: 'Messages retrived successfully', messages: messages }, status: :ok

    rescue Exception => ex
      render json: { error:ex, message: "unable to Retrive messages"} , status: :unprocessable_entity
    end
  end

  def create
    begin
      CreateMessageJob.perform_now(params[:application_token],params[:chat_number],params[:body])
      
      render json:{ succ_message: 'Message sent to queue successfully'}, status: :ok
    rescue Exception => ex
      render json: { error:ex, message: "unable to create message"} , status: :unprocessable_entity
    end
  end

  def update
    begin
      UpdateMessageJob.perform_now(params[:application_token],params[:chat_number],params[:number],params[:body])
      render json:{ succ_message: 'update Message sent successfully'}, status: :ok

    rescue Exception => ex
      render json: { error:ex, message: "unable to update message"} , status: :unprocessable_entity

    end
  end
end
