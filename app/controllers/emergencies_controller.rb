class EmergenciesController < ApplicationController
  before_action :find_emergency, only: [:update, :show]

  def index
    render(
      json: Emergency.all,
      full_responses: [Emergency.resolved.count, Emergency.count],
      meta_key: :full_responses
    )
  end

  def show
    if @emergency
      render json: @emergency
    else
      render_not_found
    end
  end

  def create
    emergency = Emergency.new(create_emergency_params)
    if emergency.save
      render json: emergency, status: :created
    else
      render_unprocessable(emergency.errors)
    end
  end

  def update
    if @emergency.update(update_emergency_params)
      render json:  @emergency
    else
      render_unprocessable(@emergency.errors)
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
    @emergency = Emergency.find_by_code(params[:id])
  end
end
