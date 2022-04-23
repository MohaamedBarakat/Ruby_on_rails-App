require 'elasticsearch/model'

class Message < ApplicationRecord
    belongs_to :chats, optional: true
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
end

