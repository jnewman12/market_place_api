require "rails_helper"

describe OrderMailer, type: :mailer do
  include Rails.application.routes.url_helpers

  describe '.send_confirmation' do 
  	before(:all) do 
  	  @order = FactoryGirl.create :order
  	  @user = @order.user
  	  @order_mailer = OrderMailer.send_confirmation(@order)	
  	end

  	it "should be ready to deliver the email as soon as it's passed in" do 
  	  @order_mailer.should deliver_to(@user.email)	
  	end

  	it "should be set to be sent from no-reply@marketplace.com" do 
  	  @order_mailer.should deliver_from("no-reply@marketplace.com")	
  	end

  	it "should contain the user message in the email body" do 
  	  @order_mailer.should have_body_text(/Order: ##{@order.id}/)	
  	end

  	it "should have the correct subject line" do 
  	  @order_mailer.should have_subject(/Order Confirmation/)	
  	end

  	it "should have the products count" do 
  	  @order_mailer.should have_body_text(/You ordered #{@user.products.count} products:/)	
  	end
  end
end
