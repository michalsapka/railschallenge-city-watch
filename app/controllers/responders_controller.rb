class RespondersController < ApplicationController
  before_action :find_responder, only: [:update, :show]
  before_action :find_responders, only: [:index]

  def index
    render json: @responders
  end

  def show
    if @responder
      render json: @responder
    else
      render json: {message: '404 not found'}, status: 404
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
    if @responder.update(update_responder_params)
      render json:  @responder
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

  # Finds all responders or avalible responders for ?show=capacity
  def find_responders
    if params[:show] == "capacity"
      @responders = Responder.capacity
    else
      @responders = Responder.all
    end
  end
end
