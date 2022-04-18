Rails.application.routes.draw do



  resources :applications, except:[:destroy], param: :token do
    resources :chats, except:[:destroy], controller:'applications/chats', param: :number do
      resources :messages, except:[:destroy,:show], controller:'applications/chats/messages', param: :number
    end
  end

end
