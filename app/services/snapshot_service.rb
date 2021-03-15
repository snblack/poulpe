class SnapshotService
  attr_reader :asin

  def initialize(asin)
    @asin = asin
  end

  def call
    agent = Mechanize.new
    agent.user_agent = 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11'

    begin
      page = agent.get("https://www.amazon.com/dp/#{@asin}/")
    rescue Mechanize::ResponseCodeError => e
      text_error = e.page.title.strip
      code_error = e.response_code

      snapshot = Snapshot.new
      product.errors.add("#{text_error}:", code_error )
      return product
    end

    title_not_formatted = page.title
    @title = title_not_formatted.gsub("Amazon.com: ", "")

    image_json = page.search("div[id=imgTagWrapperId] img").first['data-a-dynamic-image']
    @image = JSON.parse(image_json).keys.first

    @rating = page.search('#averageCustomerReviews span.a-icon-alt').first.text

    @reviews = page.search('#acrCustomerReviewText').first.text

    snapshot = Snapshot.new(title: @title, image: @image, rating: @rating, reviews: @reviews)
    snapshot

  end

end
