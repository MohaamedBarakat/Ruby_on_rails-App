class UpdateApplicationJob < ApplicationJob
  queue_as :default
  #sidekiq_options queue:
  def perform(token,new_name)
    Application.transaction do
      application = Application.find_by token: token
      application.name = new_name
      application.save
    end
  end
end
