class RespondersController < ApplicationController
  before_action :find_responder, only: [:update, :show]

  def show
    if @responder
      render json: {responder: @responder.to_json }
    else
      render json: {message: '404 not found'}, status: 404
    end
  end

  def create
    @responder = Responder.new(create_responder_params)
    if @responder.save
      render json: {responder: @responder.to_json }
    else
      render json: { message: @responder.errors }, status: 422
    end
  end

  def update
    if @responder.update(update_responder_params)
      render json: {responder: @responder.to_json }
    end
  end

  private

  def create_responder_params
    params.require(:responder).permit(:name, :type, :capacity)
  end

  def update_responder_params
    params.require(:responder).permit(:on_duty)
  end

  def find_responder
    @responder = Responder.find_by_slug(params[:id].parameterize)
  end
end
