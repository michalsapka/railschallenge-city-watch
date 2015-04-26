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
      render_not_found
    end
  end

  def create
    @responder = Responder.new(create_responder_params)
    if @responder.save
      render json: @responder, status: :created
    else
      render_unprocessable(@responder.errors)
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
