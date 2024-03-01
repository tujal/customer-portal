class ApplicationController < ActionController::Base
  # http_basic_authenticate_with name: "a", password: "1"
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    add_flash_types :info, :error, :success

  private
    def record_not_found
      render plain: "404 Not Found", status: 404
    end
end
