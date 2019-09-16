class Api::V1::GifsController < ApplicationController
  def index
    render json: GifsSerializer.new(ForecastFacade.new(params[:location]))
  end
end
