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
        # viewから送ってくるitem_idを頼りに@itemを探す
        @item_id = Item.find(params[:item_id]).id
        # ブラウザ側からサーバーに渡されるsession.idを取得
        @session_id = session.id
        # session_idとitem_idのカラムにそれぞれ、@item_id,@session_idの値を格納
        @chosenitem = Chosenitem.new(session_id:@session_id,item_id:@item_id)
        @chosenitem.save

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
