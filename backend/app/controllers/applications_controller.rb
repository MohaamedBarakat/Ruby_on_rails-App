class ApplicationsController < ApplicationController
  def index
    render json: {message: "hello"}
  end

  def create
  end

  def show
  end

  def update
  end
  private

  def generate_token
    token = loop do
      random_token = SecureRandom.urlsafe_base64(32, false)
      break random_token unless Book.exists?(token: random_token)
    end
  end
  
end
