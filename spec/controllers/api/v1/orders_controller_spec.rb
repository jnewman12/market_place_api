require 'rails_helper'

describe Api::V1::OrdersController, type: :controller do
	describe "GET #Index" do 
		before(:each) do 
		  current_user = FactoryGirl.create :user
		  api_authorization_header(current_user.auth_token)
		  4.times {FactoryGirl.create :order, user: current_user }
		  get :index, user_id: current_user.id
		end

		it "returns 4 order records for the user" do 
		  order_response = json_response[:orders]
		  # expect(order_response).to have(4).items 	
		  order_response.should have(4).items
		end

		it { should respond_with 200 }
	end

	describe "POST #Create" do 
	  before(:each) do 
	  	current_user = FactoryGirl.create :user 
	  	api_authorization_header(current_user.auth_token)

	  	product_1 = FactoryGirl.create :product
	  	product_2 = FactoryGirl.create :product

	  	order_params = { product_ids: [product_1.id, product_2.id] }
	  	post :create, user_id: current_user.id, order: order_params
	  end	

	  it "returns just the user record" do 
	  	order_response = json_response[:order] 
	  	# expect(order_response[:id]).to be_present 
	  	order_response[:id].should be_present
	  end

	  it { should respond_with 201 }
	end


	describe "GET #Show" do 
	  before(:each) do 
	  	current_user = FactoryGirl.create :user 
	  	api_authorization_header(current_user.auth_token)
	  	@order = FactoryGirl.create :order, user: current_user
	  	get :show, user_id: current_user.id, id: @order.id 
	  end	

	  it "returns the user record matching the id" do 
	  	order_response = json_response[:order]
	  	# expect(order_response[:id]).to eql @order.id 
	  	order_response[:id].should eql @order.id 
	  end

	  it { should respond_with 200 }
	end
end