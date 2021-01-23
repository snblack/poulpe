require 'rubygems'
require 'mechanize'
require 'byebug'

puts 'Введите ASIN'
asinx = gets.chomp.to_s

puts 'Введите фразу 1'
phrase = gets.chomp.to_s


agent = Mechanize.new
agent.user_agent = 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11'

page = agent.get('https://www.amazon.com/')

amazon_form = page.form('site-search')

amazon_form['field-keywords'] = phrase

page = agent.submit(amazon_form, amazon_form.buttons.first)

products = []

page.search('.sg-col-4-of-12.s-result-item.s-asin.sg-col-4-of-16.sg-col.sg-col-4-of-20').each do |product|
  title = product.search('span.a-size-base-plus.a-color-base.a-text-normal').text
  asin = product['data-asin']

  products.push(
    asin: asin,
    title: title
  )
end


count = 0

products.each do |pro|
  count += 1
  if pro.has_value?(asinx)
    puts count
  end
end
