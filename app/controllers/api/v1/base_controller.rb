class Api::V1::BaseController < ActionController::Base
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/vnd.angularapp.v1' }
  respond_to :json

  rescue_from Exception, with: :generic_exception
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  private

  def record_not_found(error)
    respond_to do |format|
      format.json { render :json => {:error => error.message}, :status => 404 }
    end
  end

  def generic_exception(error)
    respond_to do |format|
      format.json { render :json => {:error => error.message}, :status => 500 }
    end
  end
end