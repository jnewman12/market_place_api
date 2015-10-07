require 'rails_helper'

describe Api::V1::ProductsController do
	describe "#GET show" do 
		before(:each) do 
			@product = FactoryGirl.create :product
			get :show, id: @product.id
		end

		it "returns the product information of a certain id" do 
			product_response = json_response
			# expect(product_response[:title]).to eql @product.title
			product_response[:title].should eql @product.title
		end
		it { should respond_with 200 }
	end

	describe "#GET index" do 
		# added collection matchers (have(4)) gem, was core now a gem
		before(:each) do 
			4.times { FactoryGirl.create :product }
			get :index
		end

		it "returns 4 unique products" do 
			products_response = json_response
			# expect(products_response[:products]).to have(4).items
			products_response[:products].should have(4).items
		end
		it { should respond_with 200 }
	end

	# describe "#POST create" do
	#   context "when it is sucessfully created" do 
	# 	before(:each) do 
	#       user = FactoryGirl.create :user 
	#       @product_attributes = FactoryGirl.attributes_for :product
	#       api_authorization_header(user.auth_token)
	#       post :create, { user_id: user.id, product: @product_attributes } 
	# 	end

	# 	it "renders the json response of a sucessful product" do 
	# 	  product_response = json_response
	# 	  # expect(product_response[:title]).to eql @product_attributes[:title]
	# 	  product_response[:title].should eql @product_attributes[:title]
	# 	end
	# 	it { should respond_with 201 }
	#   end

	#   context "when it is not sucessfully created" do 
	#   	before(:each) do
	#   	        user = FactoryGirl.create :user
	#   	        @invalid_product_attributes = { title: "Smart TV", price: "Twelve dollars" }
	#   	        api_authorization_header user.auth_token
	#   	        post :create, { user_id: user.id, product: @invalid_product_attributes }
	#   	end

	# 	  it "renders a json error" do 
	# 	  	product_response = json_response
	# 	  	# expect(product_response).to have_key(:errors)
	# 	  	product_response[:title].should have_key(:errors)
	# 	  end

	# 	  it "renders the json error describing why it was not created" do 
	# 	  	product_response = json_response
	# 	  	# expect(product_response[:errors][:price]).to include "is not a number"
	# 	  	product_response[:errors][:price].should include "is not a number"
	# 	  end

	# 	  it { should respond_with 422 }
	#     end
	# end
	describe "POST #create" do
	  context "when it is successfully created" do
	    before(:each) do
	      user = FactoryGirl.create :user
	      @product_attributes = FactoryGirl.attributes_for :product
	      api_authorization_header user.auth_token
	      post :create, { user_id: user.id, product: @product_attributes }
	    end

	    it "renders the json response for the product created" do
	      product_response = json_response
	      # expect(product_response[:title]).to eql @product_attributes[:title]
	      product_response[:title].should eql @product_attributes[:title]
	    end

	    it { should respond_with 201 }
	  end

	  context "when it is not created" do
	    before(:each) do
	      user = FactoryGirl.create :user
	      @invalid_product_attributes = { title: "Smart TV", price: "Twelve dollars" }
	      api_authorization_header user.auth_token
	      post :create, { user_id: user.id, product: @invalid_product_attributes }
	    end

	    it "renders an errors json" do
	      product_response = json_response
	      # expect(product_response).to have_key(:errors)
	      product_response.should have_key(:errors)
	    end

	    it "renders the json errors on why the product could not be created" do
	      product_response = json_response
	      # expect(product_response[:errors][:price]).to include "is not a number"
	      product_response[:errors][:price].should include "is not a number"
	    end

	    it { should respond_with 422 }
	  end
	end
end