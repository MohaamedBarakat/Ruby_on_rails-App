class UpdateMessageJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(token,chat_number,message_number,new_body)
    application = Application.find_by token: token

      chat = Chat.where(application_id: application.id, number: chat_number).first

      message = []
      Message.transaction do
        message = Message.where(chats_id: chat.id , number:message_number ).first
        message.body = new_body
        message_count_update(chat.id)
        message.save!
      end
  end
  private
  def message_count_update(chat_id)
    number_of_message = Message.where(chats_id: chat_id).count
    chat = Chat.find_by(id: chat_id)
    chat.messages_count = number_of_message
    chat.save!
  end
end
