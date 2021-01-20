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

    ## get title and image for product from Amazon
    ## get product or errors
    @product = InfoProductService.new(asin).call

   if @product.save
     redirect_to products_path, notice: 'Your product succesfully added'
   else
     render :new
   end

  end
end
