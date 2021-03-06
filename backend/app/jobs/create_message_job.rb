class CreateMessageJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(token,number,body)
    application = Application.find_by token: token
    maximum_message_num = 0
    chat = Chat.where(application_id: application.id, number: number).first
    messages_exist = Message.find_by chats_id: chat.id
    if messages_exist
      maximum_message_num = Message.select('MAX(number) AS number').group(:chats_id).having(chats_id: chat.id).first
    end
    if maximum_message_num != 0
      maximum_message_num = maximum_message_num.number.to_i + 1
    else
      maximum_message_num = 1
    end
    
    message = []
    Message.transaction do
      message = Message.new chats_id: chat.id, body: body, number: maximum_message_num

      number_of_message = Message.where(chats_id: chat.id).count
      chat_upd = Chat.find_by(id: chat.id)
      chat_upd.messages_count = number_of_message
      chat_upd.save!
      message.save!
    end
  end

end
