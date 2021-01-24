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
        # searchメソッドでユーザーが検索したものがparamsの中に入っている.searchメソッドはcompetition.rbに定義する
        @search_params = competition_search_params
        @competitions = past_competitions
                            .paginate(page: params[:page], per_page: 5)
                            .order(period_start: "DESC")
                            .search(@search_params)

        # chosenitemsとitemsテーブルをひっつけて、competition_idで分けてから,また、item_idで分けて、item_idをカウントした
        # item_idの個数がわかったから、それを元にランク付けを行った
        # RANK() OVER (PARTITION BY competition_id ORDER BY COUNT DESC) AS rnk
        #  → competition_idごとに振り分けて、COUNTの数によって順位付けして、rnk(rankはキーワードになっているから使えない)という列を作り、そこに表示
        # 最後に、WHEREでrnk=1のものを指定し、各competition_idでグルーピングする
        # competition_idでくくるときは、GROUP BY句で指定したもの以外はSELECT句にはおけない
        # しかし、集約関数は(MAXやMINなど)は書くことができる。だから、MINで一番小さいitem_idを持ってきて、他の項目もminで持ってくる(min統一しないとデータがねじれる)
        winners_in_index =
            "SELECT
                competition_id,
                MIN(id) AS id,
                MIN(image) AS image,
                MIN(name) AS name,
                MIN(count) AS count,
                MIN(rnk) AS rnk
            FROM
                (SELECT
                    *,
                    RANK() OVER (PARTITION BY competition_id ORDER BY COUNT DESC) rnk
                FROM (SELECT
                    items.competition_id,
                    items.id,
                    items.image,
                    items.name,
                    count(*) AS count
                    FROM
                        chosenitems INNER JOIN items ON chosenitems.item_id = items.id
                        GROUP BY items.competition_id,items.id) AS t) AS tt
            WHERE rnk = 1
            GROUP BY competition_id;"
        @winners_in_index= ActiveRecord::Base.connection.select_all(winners_in_index).to_ary

    end


    # GET /competition/:id
    def show
        @competition = Competition.find(params[:id])

        # RANK()のariasでrankはキーワード指定になっているから使えない
        rankeditems =
            "SELECT *
                FROM (
                    SELECT
                        *,
                        RANK() OVER (PARTITION BY competition_id ORDER BY COUNT DESC) AS rnk
                        FROM (
                            SELECT
                                items.competition_id,
                                items.id,
                                items.image,
                                items.name,
                                count(*) AS count
                            FROM chosenitems INNER JOIN items ON chosenitems.item_id = items.id
                            GROUP BY items.competition_id, items.id
                    ) AS t
                ) AS tt
            ORDER BY COUNT DESC"

        @rankeditems = ActiveRecord::Base.connection.select_all(rankeditems).to_ary
    end

    private
    # 受け取った検索パラメータをチェック
    # params.fetch(:search, {})でparams[:search]が空の場合は{}を、空でない場合は、params[:search]を返す
    def competition_search_params
        params.fetch(:search, {}).permit(:name, :period_start, :period_end)
    end
end