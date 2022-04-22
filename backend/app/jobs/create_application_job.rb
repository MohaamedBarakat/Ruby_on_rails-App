class CreateApplicationJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(generated_token,name)
    application = Application.new token: generated_token, name: name
    application.save
  end
  
end
