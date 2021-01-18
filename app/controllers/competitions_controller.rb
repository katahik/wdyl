class CompetitionsController < ApplicationController
    # Dateライブラリを読み込む
    require "date"

    # GET /competitions
    # 現在、大会中のものは表示させない。あくまで、過去の大会のみ表示
    def index
        # 今開催中の大会を表示させない。過去の大会のみを表示させる。
        past_competitions =
            Competition.where.not(period_start: -Float::INFINITY..Date.today, period_end: Date.today..Float::INFINITY)

        # will_paginateのgemを使ってページネーションを作成
        # params[:page]はwill_paginateによって自動で生成される
        # 今回は、オプションで1ページあたりの項目数を5に指定（デフォルトは30）
        @competitions = past_competitions.paginate(page: params[:page], per_page: 5).order(period_start: "DESC")

        # 各competitionの1位を探す
        # competition_idでグループ分けして、その中でpointsが一番高いitemを抽出する
        query = "SELECT *,MAX(points) FROM items GROUP BY competition_id"
        @winners = Item.find_by_sql(query)

        # chosenitemsとitemsテーブルをひっつけて、competition_idで分けてから,また、item_idで分けて、item_idをカウントした
        # item_idの個数がわかったから、それを元にランク付けを行った
        # RANK() OVER (PARTITION BY competition_id ORDER BY COUNT DESC) AS rank
        #  → competition_idごとに振り分けて、COUNTの数によって順位付けして、rankという列を作り、そこに表示
        # rankが1のもののみを抽出する
        #
        query2 =
            "SELECT *
                FROM (
                    SELECT
                        *,
                        RANK() OVER (PARTITION BY competition_id ORDER BY COUNT DESC) AS rank
                    FROM (
                        SELECT
                            items.competition_id,
                            items.id,
                            items.image,
                            count(*) AS count
                        FROM chosenitems INNER JOIN items ON chosenitems.item_id = items.id
                        GROUP BY items.competition_id, items.id
                    ) AS t
                ) AS tt
            WHERE rank = 1"
        # select_all -> セレクト文の結果取得
        con = ActiveRecord::Base.connection
        result = con.select_all(query2)
        @winners2 = result.to_ary
    end

    # GET /competition/:id
    def show
        @competition = Competition.find(params[:id])
        @items = @competition.items.order(points: "DESC").paginate(page: params[:page], per_page: 5)
    end

end