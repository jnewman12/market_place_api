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
end