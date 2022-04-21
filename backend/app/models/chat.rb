class Chat < ApplicationRecord
    belongs_to :applications, optional: true
    has_many :messages
end
