# frozen_string_literal: true

class YearToDateHighsController < ApplicationController
  require 'open-uri'

  URL = 'https://finance.yahoo.co.jp/stocks/ranking/yearToDateHigh?market=all&term=daily'

  def index
    @year_to_date_highs = load_year_to_date_highs
  end

  private

  def load_year_to_date_highs
    htmls = read_htmls
    docs = parse_htmls(htmls)
    pick_data(docs)
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

  def pick_data(docks)
    docks.each_with_object([]) do |doc, array|
      doc.css('table tbody tr').each do |element|
        array << element.at_css('ul li').children.text
      end
    end
  end
end
