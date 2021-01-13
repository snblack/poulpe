require 'rubygems'
require 'mechanize'

agent = Mechanize.new
agent.user_agent = 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11'

page = agent.get('https://www.amazon.com/')

amazon_form = page.form('site-search')

amazon_form['field-keywords'] = 'magsafe 2 65w'

page = agent.submit(amazon_form, amazon_form.buttons.first)

products = []
page.search('.sg-col-4-of-12.s-result-item.s-asin.sg-col-4-of-16.sg-col.sg-col-4-of-20').each do |product|
  title = product.search('span.a-size-base-plus.a-color-base.a-text-normal').text
  sponsored = product.search('span.a-size-mini.a-color-base').text
  badge = product.search('span.a-badge-text').text
  badge_addition = product.search('span.a-badge-supplementary-text.a-text-ellipsis').text
  price_actual = product.search('span.a-offscreen').children.first.to_s
  price_old = product.search('span.a-price.a-text-price').search('span.a-offscreen').text
  reviews_count = product.search('div.a-section.a-spacing-none.a-spacing-top-micro').search('span.a-size-base').text
  review_stars = product.search('div.a-row.a-size-small').search('span.a-icon-alt').text
  main_image = product.search('div.a-section.aok-relative.s-image-square-aspect').search('img').first.first[1]
  asin = product['data-asin']

  product_page_url = product.search('h2.a-size-mini.a-spacing-none.a-color-base.s-line-clamp-4').children[1].values[1]

  product_page = agent.get("https://www.amazon.com/#{product_page_url}")

  product_page.search('ul.a-unordered-list.a-vertical.a-spacing-mini').each do |bool|
    @boolit1 = bool.search('span.a-list-item')[1]&.children&.text&.strip
    @boolit2 = bool.search('span.a-list-item')[2]&.children&.text&.strip
    @boolit3 = bool.search('span.a-list-item')[3]&.children&.text&.strip
    @boolit4 = bool.search('span.a-list-item')[4]&.children&.text&.strip
    @boolit5 = bool.search('span.a-list-item')[5]&.children&.text&.strip
  end

  products.push(
    asin: asin,
    title: title,
    sponsored: sponsored,
    badge: badge,
    badge_addition: badge_addition,
    price_actual: price_actual,
    price_old: price_old,
    reviews_count: reviews_count,
    review_stars: review_stars,
    main_image: main_image,
    product_page_url: product_page_url,
    boolit1: @boolit1,
    boolit2: @boolit2,
    boolit3: @boolit3,
    boolit4: @boolit4,
    boolit5: @boolit5
  )
end
