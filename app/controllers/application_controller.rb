class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :previous_page

  private

    def validate_search_key
      # params[:q].class => string
      # Items_helper need @query_array
      @query_array = params[:q].gsub(/\\|\'|\/|\?/, "").strip.split(/\s+/) if params[:q].present?
      search_criteria(@query_array) if @query_array.present? # !!!
    end

    def previous_page
      session[:last_page] = request.env['HTTP_REFERER'] if !['create', 'update'].include?(action_name)
    end
    
end
