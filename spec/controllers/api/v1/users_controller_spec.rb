require 'rails_helper'

# syntax change to a structure like github.com/jnewman12/rspec-example
# comments are the newer expect syntax (which is the one recommended),
# and the uncommented ones are the should syntax which was enabled in rails_helper.rb
describe Api::V1::UsersController do
	# before block gone here, now in RequestHelper module

	describe "GET #show" do 
		before (:each) do 
			@user = FactoryGirl.create :user
			get :show, id: @user.id, format: :json
		end

		it "returns the information about the report in a hash" do 
			user_response = json_response
			# expect(user_response[:email]).to eql @user.email
			user_response[:email].should eql @user.email
		end

		it { should respond_with 200 }
	end

	describe "POST #create" do
	 # this is what i was missing in github.com/jnewman12/respec-example, minus the json 
		before(:each) do
	        @user_attributes = FactoryGirl.attributes_for :user 
	        post :create, { user: @user_attributes }, format: :json
		end

		it "renders the json attributes for the user just created" do 
			user_response = json_response
			# expect(user_response[:email]).to eql @user_attributes[:email]
			user_response[:email].should eql @user_attributes[:email]
		end
		it { should respond_with 201 }

		context "when it is not created" do 
			before(:each) do
		       @invalid_user_attributes = { password: "12345678",
		                                    password_confirmation: "12345678" }
		       post :create, { user: @invalid_user_attributes }, format: :json
			end

			it "renders a JSON error" do 
				user_response = json_response
				# expect(user_response).to have_key(:errors)
				user_response.should have_key(:errors)
			end

			it "renders an error why the user was not created" do 
				user_response = json_response
				# expect(user_response[:errors][:email]).to include "can't be blank"
				user_response[:errors][:email].should include "can't be blank"
			end
			it { should respond_with 422 }
		end
	end

	describe "PUT/PATCH #update" do

	    context "when is successfully updated" do
	      before(:each) do
	        @user = FactoryGirl.create :user
	        patch :update, { id: @user.id,
	                         user: { email: "newmail@example.com" } }, format: :json
	      end

	      it "renders the json representation for the updated user" do
	        user_response = json_response
	        # expect(user_response[:email]).to eql "newmail@example.com"
	        user_response[:email].should eql "newmail@example.com"
	      end

	      it { should respond_with 200 }
	    end

	    context "when is not created" do
	      before(:each) do
	        @user = FactoryGirl.create :user
	        patch :update, { id: @user.id,
	                         user: { email: "bademail.com" } }, format: :json
	      end

	      it "renders an errors json" do
	       user_response = json_response
	        # expect(user_response).to have_key(:errors)
	        user_response.should have_key(:errors)
	      end

	      it "renders the json errors on whye the user could not be created" do
	        user_response = json_response
	        # expect(user_response[:errors][:email]).to include "is invalid"
	        user_response[:errors][:email].should include "is invalid"
	      end

	      it { should respond_with 422 }
	    end
	end

	describe "DELETE #destroy" do 
		before(:each) do 
			@user = FactoryGirl.create :user 
			delete :destroy, { id: @user.id }, format: :json 
		end
		it { should respond_with 204}
	end

end