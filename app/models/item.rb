class Item < ApplicationRecord
    belongs_to :competition

    has_many :chosenitems, class_name: "Chosenitem",
             foreign_key: "item_id"
end
