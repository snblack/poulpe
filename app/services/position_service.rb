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

    page.search('div .s-main-slot.s-search-results').search('div[data-component-type=s-search-result]').each do |product|
      sponsored = product.search('a.s-sponsored-label-text').search('span[1]/span').text
      asin = product['data-asin']

      products.push(
        asin: asin,
        sponsored: sponsored
      )
    end

    products = products.select { |pr| pr[:sponsored] == ''}

    count = 0

    products.each do |product|
      count += 1
      @answer = product.values.include?(asin)
      break if @answer
    end

    if @answer
      count
    else
      100
    end
  end

end
