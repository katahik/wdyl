class Api::CompetitionsController < ApplicationController
    def index
        @competitions = Competition.order('created_at DESC')
    end
end
