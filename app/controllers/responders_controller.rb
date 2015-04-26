class RespondersController < ApplicationController
  before_action :find_responder, only: [:update, :show]

  def index
    if params[:show] && params[:show] == 'capacity'
      render json: { capacity: Responder.capacity }
    else
      render json: Responder.all
    end
  end

  def show
    if @responder
      render json: @responder
    else
      render json: { message: 'page not found' }, status: 404
    end
  end

  def create
    @responder = Responder.new(create_responder_params)
    if @responder.save
      render json: @responder, status: 201
    else
      render json: { message: @responder.errors }, status: 422
    end
  end

  def update
    render json:  @responder if @responder.update(update_responder_params)
  end

  private

  def create_responder_params
    params.require(:responder).permit(:name, :type, :capacity)
  end

  def update_responder_params
    params.require(:responder).permit(:on_duty)
  end

  def find_responder
    @responder = Responder.find_by_name(params[:id])
  end
end
