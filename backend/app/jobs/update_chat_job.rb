class UpdateChatJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(token,number,new_name)
    chat = []
    Chat.transaction do
      application = Application.find_by token: token
      if !application.id
        raise "token did not identfiy any application"
      end
      chat = Chat.where( application_id: application.id , number: number).first
      chat.name = new_name
      chat.save!
    end
  end
  
end
