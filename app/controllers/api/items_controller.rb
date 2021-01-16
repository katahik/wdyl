class Api::ItemsController < ApplicationController

    def index
        @candidate_items = candidate_items
        render json: @candidate_items
    end

    # def update
    #     # クリックされたitemのidを頼りに選択されたitemを探す
    #     @selected_item = Item.find(params[:id])
    #     @selected_item.points += 1
    #     @selected_item.save
    #     @candidate_items = candidate_items
    #     render json: @candidate_items
    # end

    def create

        @item = Item.find(params[:item_id])
        # 渡されたitem_idから該当のitemを検索できた。
        # 次は、いまデータベースに入っているsession_idと@itemの組み合わせをDBに保存する
        @session = Session.all

        @chosenitem = Chosenitem.new()
        @chosenitem.save

        byebug
        @candidate_items = candidate_items
        render json: @candidate_items
    end

    private

    # candidate 候補
    def candidate_items
        Competition
            .find_by(period_start: -Float::INFINITY..Date.today, period_end: Date.today..Float::INFINITY)
            .items
            .order("RANDOM()")
            .limit(2)
    end


end
