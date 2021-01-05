class Api::CompetitionsController < ApplicationController
    def index
        @competitions = Competition.order('created_at DESC')
    end

    def create
        @competition = Competition.new(competition_params)
        if @competition.save
            render :show, status: :created
        else
            render json: @competition.errors, status: :unprocessable_entity
        end
    end

    private
    def competition_params
        params.permit(:name,:period_start,:period_end)
    end
end
