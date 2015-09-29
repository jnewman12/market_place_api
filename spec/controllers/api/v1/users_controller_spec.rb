require 'rails_helper'

# syntax change to a structure like github.com/jnewman12/rspec-example
describe Api::V1::UsersController do
	before (:each) { request.headers['Accept'] = "application/vnd.marketplace.v1" }

	describe "GET #show" do 
		before (:each) do 
			@user = FactoryGirl.create :user
			get :show, id: @user.id, format: :json
		end

		it "returns the information about the report in a hash" do 
			user_response = JSON.parse(response.body, symbolize_names: true)
			# expect(user_response[:email]).to eql @user.email
			user_response[:email].should eql @user.email
		end

		it { should respond_with 200 }
	end

end