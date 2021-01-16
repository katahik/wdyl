class Session < ApplicationRecord
    # クラス名を指定
    has_many :chosenitems, class_name: "Chosenitem",
             foreign_key: "session_id"
end