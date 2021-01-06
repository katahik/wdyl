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

    def update
        @selected_id = params[:id]
        # idを頼りに該当のitemを探す
        @selected_item = Item.find(@selected_id)
        # そのアイテムのpointsカラムに+1
        @selected_item.points += 1
        # 保存
        @selected_item.save
        # 今日開催中の大会のitemsをRANDOMメソッドで並び替え、その中の2つを@random_itemsに入れて、テンプレートへ渡す
        # @random_items = in_session_competition.items.order("RANDOM()").limit(2)
        redirect_to("/")
    end

end
