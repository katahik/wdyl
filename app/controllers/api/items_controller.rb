class Api::ItemsController < ApplicationController
    require "date"

    def index
        # Competitionモデルの中で、period_startが今日以前で、なおかつ、
        # period_endが今日以降をin_session_competitionに格納する
        in_session_competition =
            Competition.find_by(period_start: -Float::INFINITY..Date.today, period_end: Date.today..Float::INFINITY)

        # 今日開催中の大会のitemsをRANDOMメソッドで並び替え、その中の2つを@random_itemsに入れて、テンプレートへ渡す
        @random_items = in_session_competition.items.order("RANDOM()").limit(2)
    end

end
