class ProductSerializer < ActiveModel::Serializer
 	attributes :id, :title, :published
 	attributes :user

 	# this reduces response time about 90%
 	def cache_key
	  [object, scope]
	end

	def user	
	  object.user.as_json
	end
end
