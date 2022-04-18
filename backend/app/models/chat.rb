class Chat < ApplicationRecord
    belongs_to :applications
    has_many :messages
end
