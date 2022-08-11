# frozen_string_literal: true

class Ranking
  URL = 'https://finance.yahoo.co.jp/stocks/ranking/tradingValueHigh?market=all&term=daily'.freez

  attr_reader :ranking

  def initialize
    @ranking = load_ranking
  end

  private

  def load_ranking
    htmls = read_htmls
    docs = parse_htmls(htmls)
    pick_elements(docs)
  end

  def read_htmls
    # 200位まで取得するため対象サイトの4ページ目までを読み込む
    (1..4).each_with_object([]) do |i, array|
      array << URI.parse(URL + "&page=#{i}").open.read
    end
  end

  def parse_htmls(htmls)
    htmls.each_with_object([]) do |html, array|
      array << Nokogiri::HTML.parse(html)
    end
  end

  def pick_elements(docks)
    docks.each_with_object([]) do |doc, array|
      doc.css('table tbody tr').each do |element|
        array << element.at_css('ul li').children.text
      end
    end
  end
end
