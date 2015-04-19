class EmergenciesController < ApplicationController
  def index
    render json: Emergency.all
  end

  def create
    @emergency = Emergency.new(create_emergency_params)
    if @emergency.save
      render json: @emergency, status: 201
    else
      render json: { message: @emergency.errors }, status: 422
    end
  end

  private

  def create_emergency_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity)
  end
end
