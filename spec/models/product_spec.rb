require 'rails_helper'

describe Product do 
	let(:product) { FactoryGirl.build(:product) }
	subject { product }

	# default/base values
	it { should respond_to(:title) }
	it { should respond_to(:price) }
	it { should respond_to(:published) }
	it { should respond_to(:user_id) }
	it { should_not be_published }

	# validations
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:price) }
	it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
	it { should validate_presence_of(:user_id) }

	# testing the belongs_to
	it { should belong_to(:user) }

	describe ".filter_by_title" do 
		before(:each) do 
			@product1 = FactoryGirl.create :product, title: "A plasma TV"
			@product2 = FactoryGirl.create :product, title: "Fastest Laptop Ever"
			@product3 = FactoryGirl.create :product, title: "CD Player"
			@product4 = FactoryGirl.create :product, title: "LCD TV"
		end

		context "when a 'TV' title pattern is sent" do 
		  it "returns the 2 matching products" do 
		  	# expect(Product.filter_by_title("TV")).to have(2).items
		  	Product.filter_by_title("TV").should have(2).items
		  end	
		  it "returns the matching products" do 
		  	# expect(Product.filter_by_title("TV").sort).to match_array([@product1, @product4])
		  	Product.filter_by_title("TV").sort.should match_array([@product1, @product4])
		  end
		end
	end

	describe ".above_or_equal_to_price" do 
		before(:each) do
		    @product1 = FactoryGirl.create :product, price: 100
		    @product2 = FactoryGirl.create :product, price: 50
		    @product3 = FactoryGirl.create :product, price: 150
		    @product4 = FactoryGirl.create :product, price: 99
		end

		it "returns products that are above or equal to that price" do 
			# expect(Product.above_or_equal_to_price(100).sort).to match_array([@product1, @product3])
			Product.above_or_equal_to_price(100).sort.should match_array([@product1, @product3])
		end
	end

	describe ".below_or_equal_to_price" do 
		before(:each) do
		    @product1 = FactoryGirl.create :product, price: 100
		    @product2 = FactoryGirl.create :product, price: 50
		    @product3 = FactoryGirl.create :product, price: 150
		    @product4 = FactoryGirl.create :product, price: 99
		end

		it "returns products that are below or equal to that price" do
		# expect(Product.below_or_equal_to_price(99).sort).to match_array([@product2, @product4])
		 Product.below_or_equal_to_price(99).sort.should match_array([@product2, @product4]) 
		end
	end

	describe ".recent" do 
		before(:each) do
	      @product1 = FactoryGirl.create :product, price: 100
	      @product2 = FactoryGirl.create :product, price: 50
	      @product3 = FactoryGirl.create :product, price: 150
	      @product4 = FactoryGirl.create :product, price: 99

	      #we will touch some products to update them
	      @product2.touch
	      @product3.touch
		end

		it "returns the most recent updated products" do 
		 # expect(Product.recent).to match_array([@product3, @product2, @product4, @product1])	
		 Product.recent.should match_array([@product3, @product2, @product4, @product1])
		end
	end
end
