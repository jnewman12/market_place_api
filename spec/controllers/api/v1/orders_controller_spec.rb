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
	end
end
