# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :error_404
  rescue_from ActiveRecord::RecordInvalid, with: :error_400

  private

  def error_404(error)
    render json: ErrorMessageSerializer.serialize(error), status: 404
  end

  def error_400(error)
    render json: ErrorMessageSerializer.serialize(error), status: 400
  end
end
