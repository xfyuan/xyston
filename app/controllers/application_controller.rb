class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  include Authenticable

  before_action :destroy_session


  protected

    def destroy_session
      request.session_options[:skip] = true
    end

    def pagination(paginated_object, per_page)
      { pagination: { per_page: per_page.to_i,
                      total_pages: paginated_object.total_pages,
                      total_objects: paginated_object.total_count }
      }
    end
end
