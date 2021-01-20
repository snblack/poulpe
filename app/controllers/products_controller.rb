class ProductsController < ApplicationController
  FORMAT_ASIN = /^B0[A-Z0-9]{8}$/

  def index
    @products = Product.all
    @keywords = Keyword.all
  end

  def new
    @product = Product.new
  end

  def create
    @asin = params[:product][:asin]

    if @asin.match?(FORMAT_ASIN)
      @product = InfoProductService.new(@asin).call
    else
      return redirect_to products_path, notice: text_error
    end

    return redirect_to products_path, notice: error_amazon if @product.errors.any?

    if @product.save
      redirect_to products_path, notice: 'Your product succesfully added'
    else
      render :new
    end
  end

  private

  def text_error
    if @asin == ''
      'Asin can not by empty'
    else
      'Wrong format ASIN'
    end
  end

  def error_amazon
    @product.errors.full_messages.join(': ')
  end

end
