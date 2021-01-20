class Chosenitem < ApplicationRecord
    belongs_to :session, primary_key: :session_id
    belongs_to :item, class_name: "Item"
end
