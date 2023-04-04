class Scrapes::YahooFinance::RankingService < Scrapes::Base
  URL = 'https://finance.yahoo.co.jp/stocks/ranking/'.freeze

  def call
    site_pages = get_site_pages
    pick_company_codes(site_pages)
  end

  private

  def set_url
    URL
  end

  def get_site_pages
    # 200位まで取得するため対象ページのの4ページ目までを読み込む
    site_pages = (1..4).each_with_object([]) do |i, pages|
      pages << load_uri(@uri + "&page=#{i}")
    end
    site_pages.map { |page| Nokogiri::HTML.parse(page) }
  end

  def pick_company_codes(site_pages)
    site_pages.each_with_object([]) do |page, array|
      page.css('table tbody tr').each do |element|
        array << element.at_css('ul li').children.text
      end
    end
  end
end
