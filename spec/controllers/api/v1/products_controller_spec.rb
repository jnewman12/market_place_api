require 'rails_helper'

describe Api::V1::ProductsController do
	# describe "#GET show" do 
	# 	before(:each) do 
	# 		@product = FactoryGirl.create :product
	# 		get :show, id: @product.id
	# 	end

	# 	it "returns the product information of a certain id" do 
	# 		product_response = json_response[:product]
	# 		# expect(product_response[:title]).to eql @product.title
	# 		product_response[:title].should eql @product.title
	# 	end

	# 	it "has a user as an embedded object" do 
	# 		product_response = json_response[:product]
	# 		# expect(product_response[:user][:email]).to eql @product.user.email
	# 		product_response[:user][:email].should eql @product.user.email

	# 	end
	# 	it { should respond_with 200 }
	# end

	# describe "#GET index" do 
	# 	# added collection matchers (have(4)) gem, was core now a gem
	# 	before(:each) do 
	# 		4.times { FactoryGirl.create :product }
	# 		get :index
	# 	end

	# 	# setting up to return the scoped product records

	# 	it "returns 4 unique products" do 
	# 		products_response = json_response
	# 		# expect(products_response[:products]).to have(4).items
	# 		products_response[:products].should have(4).items
	# 	end

	# 	it "returns the user object into each product" do 
	# 		products_response = json_response[:products]
	# 		products_response.each do |product_response|
	# 		  # expect(product_response[:user]).to be_present
	# 		  product_response[:user].should be_present
	# 		end
	# 	end
	# 	it { should respond_with 200 }
	# end
	
	# describe "POST #create" do
	#   context "when it is successfully created" do
	#     before(:each) do
	#       user = FactoryGirl.create :user
	#       @product_attributes = FactoryGirl.attributes_for :product
	#       api_authorization_header user.auth_token
	#       post :create, { user_id: user.id, product: @product_attributes }
	#     end

	#     it "renders the json response for the product created" do
	#       product_response = json_response[:product]
	#       # expect(product_response[:title]).to eql @product_attributes[:title]
	#       product_response[:title].should eql @product_attributes[:title]
	#     end

	#     it { should respond_with 201 }
	#   end

	#   context "when it is not created" do
	#     before(:each) do
	#       user = FactoryGirl.create :user
	#       @invalid_product_attributes = { title: "Smart TV", price: "Twelve dollars" }
	#       api_authorization_header user.auth_token
	#       post :create, { user_id: user.id, product: @invalid_product_attributes }
	#     end

	#     it "renders an errors json" do
	#       product_response = json_response
	#       # expect(product_response).to have_key(:errors)
	#       product_response.should have_key(:errors)
	#     end

	#     it "renders the json errors on why the product could not be created" do
	#       product_response = json_response
	#       # expect(product_response[:errors][:price]).to include "is not a number"
	#       product_response[:errors][:price].should include "is not a number"
	#     end

	#     it { should respond_with 422 }
	#   end
	# end

	# describe "PUT/PATCH #update" do

	#   before(:each) do 
	#   	@user = FactoryGirl.create :user 
	#   	@product = FactoryGirl.create :product, user_id: @user.id 
	#   	api_authorization_header(@user.auth_token)
	#   end 

	#   context "when a product is successfully updated" do
	#     before(:each) do 
	#     	patch :update, { user_id: @user.id, id: @product.id,
	#     	product: { title: "A Kind of TV" } }
	#     end 

	#     it "renders the json response for the product updated" do
	#       product_response = json_response[:product]
	#       # expect(product_response[:title]).to eql "An expensive TV"
	#       product_response[:title].should eql "A Kind of TV"
	#     end

	#     it { should respond_with 200 }
	#   end

	#   context "when a product is not successfully updated" do 
	#   	before(:each) do 
	#   		patch :update, { user_id: @user.id, id: @product.id,
	#   		product: { price: "A Kind of thing" } }
	#   	end

	#   	it "renders a json error" do 
	#   	  product_response = json_response
	#   	  # expect(product_response).to have_key(:errors)
	#   	  product_response.should have_key(:errors)	
	#   	end

	#   	it "renders a json error explaining why" do 
	#   	  product_response = json_response
	#   	  # expect(product_response[:errors][:price]).to include "is not a number"
	#   	  product_response[:errors][:price].should include "is not a number"
	#   	end

	#   	it { should respond_with 422 }
 # 	  end
	# end

	# describe "DELETE #destroy" do 
	# 	before(:each) do
	#       @user = FactoryGirl.create :user
	#       @product = FactoryGirl.create :product, user: @user
	#       api_authorization_header @user.auth_token
	#       delete :destroy, { user_id: @user.id, id: @product.id }
	# 	end
	# 	it { should respond_with 204 }
	# end
end