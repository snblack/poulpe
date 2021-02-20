class KeywordsController < ApplicationController
  before_action :authenticate_user!

  FORMAT_KEYWORDS = /\w/

  def index
    @products = Product.all
    @keywords = Keyword.all
  end

  def new
    @product = Product.find(params[:product_id])
    @keyword = Keyword.new
  end

  def create
    @product = Product.find(params[:product_id])
    list_keywords = params[:keyword][:list_keywords]

    if list_keywords == ''
      return redirect_to products_path, notice: "Please, add one and any phrases"
    elsif !list_keywords.match?(FORMAT_KEYWORDS)
      return redirect_to products_path, notice: "Wrong format ASIN"
    end

    keywords = list_keywords.split("\n")

    keywords.each do |key|
      @keyword = @product.keywords.new(title: key)
      @keyword.save!
    end

    redirect_to products_path, notice: "Keywords for product succesfully added"
  end

  private

  def keywords_params
    params.require(:keyword).permit(:title)
  end
end
