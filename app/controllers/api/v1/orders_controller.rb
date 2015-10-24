class Api::V1::OrdersController < ApplicationController
	before_action :authenticate_with_token!
	respond_to :json

	def index
	  respond_with current_user.orders	
	end

	def show
	end

	def create
	end

	private
	def order_params
	end
end
