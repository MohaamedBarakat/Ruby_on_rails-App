class ApplicationsController < ApplicationController
  def index
    applications_data = Application.order(created_at: :asc)
    render json: {message: "Applications Retrived", data:applications_data } , status: :ok
  end

  def create
    #ChatAppJob.set(wait: 10.seconds).perform_later
    begin
      generated_token = generate_token

      application = Application.new token: generated_token, name: params[:name]
      application.save

      no_of_application = Application.count

      render json: {message: "Application Created", number_of_applications: no_of_application } , status: :created
    rescue Exception => ex
      render json: {error:ex ,message: "Cannot Create Application"} , status: :unprocessable_entity

    end
  end

  def show
    begin
      application = Application.where token: params[:token]
      is_valid_token(application)

      render json: {message: "Application Retrived",application: application } , status: :ok
    rescue Exception => ex
      render json: {error: ex ,message: "Cannot fetch Application"} , status: :unprocessable_entity
    end

  end

  def update
    begin
      application = Application.find_by token: params[:token]

      application.name = params[:name]
      application.save

      render json: {message: "Application Updated",application: application } , status: :ok
    rescue Exception => ex
      render json: {error: ex ,message: "Cannot update Application"} , status: :unprocessable_entity
    end
  end

  private
  def generate_token
    token = loop do
      random_token = SecureRandom.urlsafe_base64(32, false)
      break random_token unless Application.exists?(token: random_token)
    end
  end
  
  private
  def application_params
    params.require(:application).permit(:name)
  end

  private
  def is_valid_token(application)
    if application.count < 1
      raise "token did not identfiy any application"
    end  
  end

end
