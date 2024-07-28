require 'open-uri'
require 'date'
require 'nokogiri'

uri = 'https://kabutan.jp/stock/kabuka?code=3993'

dom = URI.parse(uri).open('User-Agent' => 'Mozilla/5.0').read

html =  Nokogiri::HTML.parse(dom)

trs = html.css('.stock_kabuka_dwm tr')

array = []
22.times do |t|
  texts = trs[t + 1].css('td')[1..2].map(&:text)
  hash = {day_high: texts[0].gsub(',', '').to_i, day_low: texts[1].gsub(',', '').to_i}
  if t == 21
    hash[:pre_day_close] = nil
  else
    hash[:pre_day_close] = trs[t + 2].css('td')[3].text.gsub(',','').to_i
  end
  array << hash
end
#
# array = [
#   {
#     day: 1,
#     day_heigh: 2865,
#     day_low: 2507,
#     pre_day_close: 2475
#   },
#   {
#     day: 2,
#     day_heigh: 2483,
#     day_low: 2260,
#     pre_day_close: 2257
#   },
#   {
#     day: 3,
#     day_heigh: 2333,
#     day_low: 2192,
#     pre_day_close: 2306
#   },
#   {
#     day: 4,
#     day_heigh: 2370,
#     day_low: 2168,
#     pre_day_close: 2143
#   },
#   {
#     day: 5,
#     day_heigh: 2170,
#     day_low: 2056,
#     pre_day_close: 2083
#   },
# ]

true_renges = array[0..19].map do |a|
  arr = []
  arr << a[:day_high] - a[:day_low]
  arr << a[:day_high] - a[:pre_day_close]
  arr << a[:day_low] - a[:pre_day_close]
  arr.max
end

puts array[0..19]
puts array[0..19].length
atr =  true_renges.sum.to_f / true_renges.length
puts atr

puts atr / trs[1].css('td')[3].text.gsub(',','').to_i * 100
