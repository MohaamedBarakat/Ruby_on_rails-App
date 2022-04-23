class CreateChatJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(token,name)
    application = []
    num_chats = 1
    Application.transaction do
      Chat.transaction do
        application = Application.find_by token: token
        chat_exist = Chat.find_by(application_id: application.id)

        if chat_exist
          num_chats = Chat.select("MAX(number) AS number").group(:application_id).having(application_id: application.id)
          num_chats = num_chats[0].number.to_i+1
        end
          chat = Chat.new application_id: application.id, number: num_chats,name: name

        application.chat_count = Chat.where(application_id: application.id).count + 1

        chat.save!
        application.save!
      end
    end
  end

end
