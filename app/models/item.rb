class Item < ApplicationRecord
    belongs_to :competition

    has_many :chosenitems, class_name: "Chosenitem",
             foreign_key: "item_id"

    # has_manyはメソッドを作るメソッド
    # 例えば@session.chosenitemsとしたら、chosenitemsの内容が出てくるなど
    # 今回はselectedsessionsメソッドを定義choseitemsテーブルに、sessionを実行
    # selectedsessionsを実行したら、choseitemsにchosenitem.rbで定義したsessionを実行してitem一覧を出す
    has_many :selectedsessions, through: :chosenitems, source: :session
end
