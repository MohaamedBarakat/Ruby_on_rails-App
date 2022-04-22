class CreateChatJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(token,name)
    application = []
    Application.transaction do
      Chat.transaction do
        application = Application.find_by token: token

        num_chats = Chat.select("MAX(number) AS number").group(:application_id).having(application_id: application.id).first

        chat = Chat.new application_id: application.id, number: num_chats.number.to_i+1,name: name

        application.chat_count = Chat.where(application_id: application.id).count + 1

        chat.save!
        application.save!
      end
    end
  end

end
