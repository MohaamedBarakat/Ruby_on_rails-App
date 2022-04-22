class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(token,number,body)
    application = Application.find_by token: token

    chat = Chat.where(application_id: application.id, number: number).first

    maximum_message_num = Message.select('MAX(number) AS number').group(:chats_id).having(chats_id: chat.id).first
    if !maximum_message_num
      maximum_message_num = 1
    else
      maximum_message_num = maximum_message_num.number.to_i + 1
    end
    
    message = []
    Message.transaction do
      message = Message.new chats_id: chat.id, body: body, number: maximum_message_num
      message.save!
    end
  end
end
