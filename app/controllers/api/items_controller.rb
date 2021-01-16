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

        @candidate_items = candidate_items
        render json: @candidate_items
        # byebug
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
