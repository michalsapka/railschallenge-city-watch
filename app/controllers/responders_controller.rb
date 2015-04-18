class RespondersController < ApplicationController
  def create
    @responder = Responder.new(responder_params)
    if @responder.save
      render json: {responder: @responder.to_json }
    else
      render json: { message: @responder.errors }, status: 422
    end
  end

  private

  def responder_params
    params.require(:responder).permit(:name, :type, :capacity)
  end
end
