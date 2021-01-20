class Competition < ApplicationRecord
    has_many :items

    # controllerでsearchメソッドを使うためここで定義
    # selfはCompetition.引数にはユーザーが入力した検索文字がparamsの中に入って渡ってくる
    def self.search(search)
        if search
            Competition.where(['name LIKE ?', "%#{search}%"])
        else
            Competition.all
        end
    end

end
