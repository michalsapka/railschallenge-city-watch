class EmergenciesController < ApplicationController

  before_action :find_emergency, only: [ :update, :show ]
  def index
    render json: Emergency.all
  end

  def show
    if @emergency
      render json: @emergency
    else
      render json: {message: 'page not found'}, status: 404
    end
  end

  def create
    @emergency = Emergency.new(create_emergency_params)
    if @emergency.save
      render json: @emergency, status: 201
    else
      render json: { message: @emergency.errors }, status: 422
    end
  end

  def update
    if @emergency.update(update_emergency_params)
      render json:  @emergency
    else
      render json: { message: @emergency.errors }, status: 422
    end
  end

  private

  def create_emergency_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity)
  end

  def update_emergency_params
    params.require(:emergency).permit(:fire_severity, :police_severity, :medical_severity, :resolved_at)
  end

  def find_emergency
    @emergency= Emergency.find_by_slug(params[:id].parameterize)
  end
end
