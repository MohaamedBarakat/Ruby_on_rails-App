class Message < ApplicationRecord
    belongs_to :chats, optional: true
end
