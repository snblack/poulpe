require 'rubygems'
require 'mechanize'

agent = Mechanize.new

page = agent.get('http://google.com/')

pp page
google_form = page.form('f')

google_form.q = 'ruby mechanize'

page = agent.submit(google_form, google_form.buttons.first)
# pp page
