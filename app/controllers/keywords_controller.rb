class KeywordsController < ApplicationController
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
    keywords = list_keywords.split("\n")

    #создать объект для каждого keyword in array
    keywords.each do |key|
      @keyword = @product.keywords.new(title: key)
      @keyword.save!
    end

    redirect_to products_path
  end

  private

  def keywords_params
    params.require(:keyword).permit(:title)
  end
end
