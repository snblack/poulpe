class PositionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @products = Product.where(user: current_user)

    @products.each do |product|
      product.keywords.each do |keyword|
        keyword.positions.create(value: PositionService.new(product.asin, keyword.title).call)
      end
    end
  end
end
