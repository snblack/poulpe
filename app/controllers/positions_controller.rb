class PositionsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @products = Product.all

    @products.each do |product|
      product.keywords.each do |keyword|
        keyword.positions.create(value: PositionService.new(product.asin, keyword.title).call)
      end

      redirect_to products_path, notice: 'Positions ware updated'
    end
  end
end
