class Api::ItemsController < ApplicationController
    require "date"

    def index
        @random_items = fetch_items
    end

    def update
        @selected_id = params[:id]
        # idを頼りに該当のitemを探す
        @selected_item = Item.find(@selected_id)
        # そのアイテムのpointsカラムに+1
        @selected_item.points += 1
        # 保存
        @selected_item.save

        @random_items = fetch_items
        # JSON形式で出力する
        render json: @random_items
    end

    private
    # fetchとは呼び出すこと
    # 今現在、開催中の大会から、2つのitemの呼び出す
    def fetch_items
        in_session_competition =
            Competition.find_by(period_start: -Float::INFINITY..Date.today, period_end: Date.today..Float::INFINITY)

        # 今日開催中の大会のitemsをRANDOMメソッドで並び替え、その中の2つを@random_itemsに入れて、テンプレートへ渡す
        in_session_competition.items.order("RANDOM()").limit(2)
    end
end
