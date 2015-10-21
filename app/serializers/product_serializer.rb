class ProductSerializer < ActiveModel::Serializer
 	attributes :id, :title, :published
 	attributes :user

 	def cache_key
	  [object, scope]
	end

	# because ActiveModel::Serializer is bullshit. this fixed the infinite loop error
	# i personally dont see the benefit in activemodel serializers, but I will keep it for now
	def user	
	  object.user.as_json
	end
end
