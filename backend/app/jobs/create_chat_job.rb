class CreateChatJob < ApplicationJob
  queue_as :default

  def perform(token,name)
    application = []
    Application.transaction do
      Chat.transaction do
        application = Application.find_by token: token

        num_chats = Chat.where(application_id: application.id).count
        num_chats+=1

        chat = Chat.new application_id: application.id, number: num_chats,name: name

        application.chat_count = Chat.where(application_id: application.id).count + 1

        chat.save!
        application.save!
      end
    end
  end
end
