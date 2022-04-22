class UpdateMessageJob < ApplicationJob
  queue_as :default

  def perform(token,chat_number,message_number,new_body)
    application = Application.find_by token: token

      chat = Chat.where(application_id: application.id, number: chat_number).first

      message = []
      Message.transaction do
        message = Message.where(chats_id: chat.id , number:message_number ).first
        message.body = new_body
        message.save!
      end
  end
end
