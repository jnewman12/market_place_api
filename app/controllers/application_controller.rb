class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include Authenticable
  respond_to :html, :json
  before_filter :add_cors_headers

  before_filter :add_cors_headers
  #before_filter {authenticate_user! unless request.method == "OPTIONS"}

 def add_cors_headers
   origin = request.headers["Origin"]
   unless (not origin.nil?) and (origin == "http://localhost" or origin.starts_with? "http://localhost:")
     # server name   	
     origin = "http://api.marketplaceapi.dev"
   end
   headers['Access-Control-Allow-Origin'] = origin
   headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, DELETE'
   allow_headers = request.headers["Access-Control-Request-Headers"]
   if allow_headers.nil?
     #shouldn't happen, but better be safe
     allow_headers = 'Origin, Authorization, Accept, Content-Type, X-HTTP-Method-Override'
   end
   headers['Access-Control-Allow-Headers'] = allow_headers
   headers['Access-Control-Allow-Credentials'] = 'true'
   headers['Access-Control-Max-Age'] = '1728000'
 end

 def empty
   render nothing: true
 end

  protected 
  def pagination(paginated_array, per_page)
    { pagination: { per_page: per_page.to_i,
                    total_pages: paginated_array.total_pages,
                    total_objects: paginated_array.total_count } }
  end
end
