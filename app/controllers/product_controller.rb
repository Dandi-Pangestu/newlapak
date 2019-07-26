class ProductController < ApplicationController
  before_action :authenticate_request
  before_action :set_product, only: [:show]

  def index
    @products = Product.order('id desc')
    api(each_serializer(@products, ProductSerializer))
  end

  def show
    api(serializer@product, ProductSerializer)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
