class Session < ApplicationRecord
    self.primary_key = :session_id
    has_many :chosenitems, class_name: "Chosenitem",
             foreign_key: "session_id"

    # has_manyはメソッドを作るメソッド
    # 例えば@session.chosenitemsとしたら、chosenitemsの内容が出てくるなど
    # 今回はchoseitemメソッドを定義choseitemsテーブルに、itemを実行
    # choseitemを実行したら、choseitemsにchosenitem.rbで定義したitemを実行してitem一覧を出す
    has_many :chooseitems, through: :chosenitems, source: :item

    # chooseメソッドを定義
    # choseitemsにitemを流し込む
    def choose(item)
        chooseitems << item
    end

end