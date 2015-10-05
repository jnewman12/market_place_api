module RequestHelper
	def json_response			
	  @json_response ||= JSON.parse(response.body, symbolize_names: true)
	end

	def api_header(version = 1)
		request.headers["Accept"] = "application/vnd.marketplace.v#{version}"
	end

	def api_response_format(format = Mime::JSON)
		request.headers['Accept'] = "#{request.headers['Accept']},#{format}"
		request.headers['Content-Type'] = format.to_s
	end

	# this is so each time we need to call current_user in the specs, we can
	def api_authorization_header(token)
	  request.headers['Authorization'] = token 
	end

	def include_default_accept_headers
		api_header
		api_response_format
	end
end