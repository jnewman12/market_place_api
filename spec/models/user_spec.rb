require 'rails_helper'

RSpec.describe User, type: :model do 
	before { @user = FactoryGirl.build(:user)}

	subject { @user }

	# user base
	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }

	it { should be_valid }

	# user validations
	it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:email) }
	it { should validate_confirmation_of(:password) }
	it { should allow_value('example@mail.com').for(:email) }

end
