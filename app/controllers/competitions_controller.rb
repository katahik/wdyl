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
        query = "SELECT *,MAX(points) FROM Items GROUP BY competition_id"
        @winners = Item.find_by_sql(query)
    end

    # GET /competition/:id
    def show
        @competition = Competition.find(params[:id])
        @items = @competition.items.order(points: "DESC").paginate(page: params[:page], per_page: 5)
    end

end