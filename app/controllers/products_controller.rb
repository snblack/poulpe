class ProductsController < ApplicationController
  before_action :authenticate_user!

  FORMAT_ASIN = /^B0[A-Z0-9]{8}$/

  def index
    @products = Product.where(user: current_user)
    @keywords = Keyword.joins(:product).where(:product => {:user => current_user})

    gon.products = @products.as_json(:include => [:snapshots, :variances])
    gon.keywords = @keywords.as_json(include: [:positions, {product: {include: :variances}}])
  end

  def new
    @product = Product.new
  end

  def create
    @asin = params[:asin]

    if @asin.match?(FORMAT_ASIN)
      @product = InfoProductService.new(@asin, current_user).call
    else
      flash.now[:notice] = text_error
      return render :new
    end

    if @product.errors.any?
      flash.now[:notice] = error_amazon
      render :new
    elsif @product.save
      redirect_to products_path, notice: 'Your product succesfully added'
    else
      flash.now[:notice] = 'Product not added'
      render :new
    end
  end

  def destroy
    @product = Product.find(params[:id])

    @product.destroy
    redirect_to products_path, notice: 'Product deleted'
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
