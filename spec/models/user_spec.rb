require 'rails_helper'

# comments are new expect syntax
# non-comments are added (old) should syntax
RSpec.describe User, type: :model do 
	before { @user = FactoryGirl.build(:user)}

	subject { @user }

	# user base values
	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should have_many(:products) }
	it { should be_valid }

	# user validations
	it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:email) }
	it { should validate_confirmation_of(:password) }
	it { should allow_value('example@mail.com').for(:email) }

	# authentication
	it { should respond_to(:auth_token) }
	it { should validate_uniqueness_of(:auth_token) }

	it { should have_many(:products) }
	it { should have_many(:orders) }

	describe "#generate_authentication_token!" do 
		it "generates a unique token" do 
			Devise.stub(:friendly_token).and_return("auniquetoken123")
			@user.generate_authentication_token!
			# expect(@user.auth_token).to eql "auniquetoken123"
			@user.auth_token.should eql "auniquetoken123"
		end

		it "generates another token when one has already been created" do 
			existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
			@user.generate_authentication_token!
			# expect(@user.auth_token).not_to eql existing_user.auth_token
			@user.auth_token.should_not eql existing_user.auth_token
		end
	end

	describe "products association" do
	   before do 
	   	@user.save
	   	# we saved 'user' in our factory so FG knows we're talking about an object
	   	# as a result, user is a attr on product, so we just pass it
	   	3.times { FactoryGirl.create :product, user: @user}
	   end 
	   it "destroys the associated products on '#Destroy'" do 
	   	products = @user.products
	   	@user.destroy
	   	  products.each do |product|
	   	  	# expect(Product.find(product)).to raise_error ActiveRecord::RecordNotFound
	   	  	Product.find(product).should raise_error ActiveRecord::RecordNotFound
	   	  end
	    end
	end

end
