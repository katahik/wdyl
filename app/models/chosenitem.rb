class Chosenitem < ApplicationRecord
    belongs_to :session, class_name:"Session"
    belongs_to :item, class_name: "Item"
end
