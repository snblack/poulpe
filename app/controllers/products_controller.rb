class ProductsController < ApplicationController
  def index
    @products = Product.all
    @keywords = Keyword.all
  end

  def new
    @product = Product.new
  end

  def create
    asin = params[:product][:asin]

    if asin == ''
      return redirect_to products_path, notice: 'Asin can not by empty'
    else
      @product = InfoProductService.new(asin).call
    end

    if @product.save
      redirect_to products_path, notice: 'Your product succesfully added'
    else
      render :new
    end
  end
end
