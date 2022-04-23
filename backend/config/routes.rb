Rails.application.routes.draw do



  resources :applications, except:[:destroy], param: :token do
    resources :chats, except:[:destroy], controller:'applications/chats', param: :number do
      resources :messages, only:[:index,:update,:create,:search], controller:'applications/chats/messages', param: :number
    end
  end
  post '/applications/:application_token/chats/:chat_number/messages/search' ,to:'applications/chats/messages#search',as:'search'
end
