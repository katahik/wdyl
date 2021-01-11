class Api::ItemsController < ApplicationController

    def index
        @random_items = two_items_at_random_in_session_competition_in_JSON_format
    end

    def update
        # @selected_id = params[:id]
        # @selected_item = Item.find(@selected_id)
        # ↓
        # クリックされたitemのidを頼りに選択されたitemを探す
        @selected_item = Item.find(params[:id])
        # そのアイテムのpointsカラムに+1
        @selected_item.points += 1
        # 保存
        @selected_item.save

        @random_items = two_items_at_random_in_session_competition_in_JSON_format
    end

    private
    # 今現在、開催中の大会から、2つのitemをランダムで呼び出し、JSON形式にして返す
    # なぜJSON形式でないとだめか
    # log「rendering head :no_content」となり画面に画像が表示されない（headerやfooterは表示されている）
    # ということは、response.dataはJSONでないと有効なデータで受け取らないのではないか
    # console.logでresponse.dataを確認したら、JSONではない場合は何も入っていなかった
    def two_items_at_random_in_session_competition_in_JSON_format
        in_session_competition =
            Competition.find_by(period_start: -Float::INFINITY..Date.today, period_end: Date.today..Float::INFINITY)

        # 今日開催中の大会のitemsをRANDOMメソッドで並び替え、その中の2つを@random_itemsに入れて、テンプレートへ渡す
        render json: in_session_competition.items.order("RANDOM()").limit(2)
    end
end
