class InfoProductService

  attr_reader :asin

  def initialize(asin, user)
    @asin = asin
    @user = user
  end

  def call
    agent = Mechanize.new
    agent.user_agent = 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11'

    begin
      page = agent.get("https://www.amazon.com/dp/#{@asin}/")
    rescue Mechanize::ResponseCodeError => e
      text_error = e.page.title.strip
      code_error = e.response_code

      product = Product.new
      product.errors.add("#{text_error}:", code_error )
      return product
    end

    title_not_formatted = page.title
    @title = title_not_formatted.gsub("Amazon.com: ", "")

    image_json = page.search("div[id=imgTagWrapperId] img").first['data-a-dynamic-image']
    @image = JSON.parse(image_json).keys.first

    product = Product.new(title: @title, asin: @asin, image: @image, user: @user)
    product
  end
end
