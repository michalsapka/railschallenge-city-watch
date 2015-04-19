class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  ActionController::Parameters.action_on_unpermitted_parameters = :raise
  rescue_from(ActionController::UnpermittedParameters) do |err|
    render json: {
      message: "found unpermitted #{'parameter'.pluralize(err.params.count)}: #{ err.params.to_sentence }"
    }, status: 422
  end

  def action_not_found
    render json: {
      message: "page not found"
    }, status: 404
  end
end
