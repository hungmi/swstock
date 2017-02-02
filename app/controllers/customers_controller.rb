class CustomersController < ApplicationController
	before_action :render_customers, only: [:new, :edit, :create, :update]
	def new
		@customer = Customer.new
		@submit_text = "新增"
	end

	def create
		@customer = Customer.new(customer_params)
		if @customer.save
			redirect_to new_item_path
		else
			render :new
		end
	end

	def edit
		@customer = Customer.find(params[:id])
		@submit_text = "儲存"
	end

	def update
		@customer = Customer.find(params[:id])
		if @customer.update(customer_params)
			redirect_to edit_customer_path(@customer)
		else
			render :edit
		end
	end

	private

	def render_customers
		@customers = Customer.all	
	end

	def customer_params
		params.require(:customer).permit(:name, :color)
	end
end