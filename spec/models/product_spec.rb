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

	it { should have_many(:placements) }
	it { should have_many(:orders).through(:placements) }	

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

	describe ".search" do
	  before(:each) do
        @product1 = FactoryGirl.create :product, price: 100, title: "Plasma tv"
        @product2 = FactoryGirl.create :product, price: 50, title: "Videogame console"
        @product3 = FactoryGirl.create :product, price: 150, title: "MP3"
        @product4 = FactoryGirl.create :product, price: 99, title: "Laptop"
	  end 

	  context "when title is 'videogame' and '100' minimum price is set" do 
	  	it "returns an empty array" do 
	  	 search_hash = { keyword: "videogame", min_price: 100 }
	  	 # expect(Product.search(search_hash)).to be_empty	
	  	 Product.search(search_hash).should be_empty
	  	end
	  end

	  context "when the title 'tv', '150' as max price and '50' as min price" do 
	  	it "returns product1" do
	  	 search_hash = { keyword: 'tv', min_price: 50, max_price: 150 }	
	     # expect(Product.search(search_hash)).to match_array([@product1])
	     Product.search(search_hash).should match_array([@product1])
	    end 
	  end

	  context "when it is an empty search result" do 
	  	it "returns all the products" do 
	  	  # expect(Product.search({})).to match_array([@product1, @product2, @product3, @product4])	
	  	  Product.search({}).should match_array([@product1, @product2, @product3, @product4])
	  	end
	  end

	  context "when product_ids are present" do 
	  	it "returns the products from the id" do 
	  	  search_hash = { product_ids: [@product1.id, @product2.id]}
	  	  # expect(Product.search(search_hash)).to match_array([@product1, @product2])
	  	  Product.search(search_hash).should match_array([@product1, @product2])	
	  	end
	  end
	end
end
