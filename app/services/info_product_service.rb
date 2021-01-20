class InfoProductService

  attr_reader :asin

  def initialize(asin)
    @asin = asin
  end

  def call
    agent = Mechanize.new
    agent.user_agent = 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11'

    page = agent.get("https://www.amazon.com/dp/#{@asin}/")
    title_not_formatted = page.title
    @title = title_not_formatted.slice(0..(title_not_formatted.rindex(':')-1))

    # @image = page.search(".imgTagWrapper").search('img').first['data-old-hires']
    image_json = page.search(".imgTagWrapper").search('img').first['data-a-dynamic-image']
    @image = JSON.parse(image_json).keys.first

    product = Product.new(title: @title, asin: @asin, image: @image)
    product
  end
end
