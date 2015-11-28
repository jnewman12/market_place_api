class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include Authenticable
  respond_to :html, :json
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  # ability to access server from different port
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
  end

  protected 
  def pagination(paginated_array, per_page)
    { pagination: { per_page: per_page.to_i,
                    total_pages: paginated_array.total_pages,
                    total_objects: paginated_array.total_count } }
  end
end
