class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      render json: RoadTripSerializer.new(RoadTripFacade.new(params))
    else
      render json: { error: "Invalid or no api_key" }, status: :unauthorized
    end
  end
end
