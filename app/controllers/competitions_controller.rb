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
        #  → competition_idごとに振り分けて、COUNTの数によって順位付けして、rnkという列を作り、そこに表示
        # 最後に、rnk=1、competitionでくくってrnkが1のものでcompetition_idでのみを抽出する
        # mySQLでaliasにrankを使うことはできない。キーワードで決まっているため
        winners_in_index =
            "SELECT *
                FROM (SELECT *,RANK() OVER (PARTITION BY competition_id ORDER BY COUNT DESC) AS rnk
                    FROM (SELECT items.competition_id,items.id,items.image,items.name,count(*) AS count
                        FROM chosenitems INNER JOIN items ON chosenitems.item_id = items.id
                            GROUP BY items.competition_id,items.id) AS t) AS tt
            WHERE rnk = 1 ORDER BY count desc;"
#         winners_in_index =
#             "SELECT * FROM(
#                 SET @rank=0,@before_line_count=0;
#                 SELECT
#                     CASE WHEN @before_line_count=count THEN @rank
#                     ELSE @rank:=@rank+1
#                     END AS rank,
#                      * ,
#                     @before_line_count:=count AS count
#
#                 FROM
# (
#                     SELECT
#                         items.competition_id,
#                         items.id,
#                         items.image,
#                         items.name,
#                         count(*) AS count
#                     FROM chosenitems INNER JOIN items ON chosenitems.item_id = items.id
#                     GROUP BY items.competition_id, items.id
#                     ) AS t
#
#
#                 ) AS tt
#             GROUP BY competition_id
#             "
        # select_all -> セレクト文の結果取得
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