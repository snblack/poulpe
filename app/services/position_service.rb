class PositionService

  attr_reader :asin, :keyword

  def initialize(asin, keyword)
    @asin = asin
    @keyword = keyword
  end

  def call
    agent = Mechanize.new
    agent.user_agent = 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11'

    # open page with issue
    page = agent.get('https://www.amazon.com/')
    amazon_form = page.form('site-search')
    amazon_form['field-keywords'] = keyword
    page = agent.submit(amazon_form, amazon_form.buttons.first)

    # count position
    products = []

    page.search('.sg-col-4-of-12.s-result-item.s-asin.sg-col-4-of-16.sg-col.sg-col-4-of-20').each do |product|
      sponsored = product.search('span.a-size-mini.a-color-base').text
      asin = product['data-asin']

      products.push(
        asin: asin,
        sponsored: sponsored
      )
    end

    count = 0

    products.each do |product|
      count += 1
      break if product.values.include?(asin)

      
    end

    count
  end

end
