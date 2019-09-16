class Api::V1::BackgroundsController < ApplicationController
  def index
    render json: BackgroundSerializer.new(
      BackgroundsFacade.new(params[:location])
    )
  end
end
