class Scrapes::Ifis::FinancialScheduleService < Scrapes::Base
  URL = 'https://kabuyoho.ifis.co.jp/'.freeze

  def call
    target_date = set_target_date
    get_financial_company_codes(target_date)
  end

  private

  def set_url
    URL
  end

  def set_target_date
    Date.today.since(3.weeks).strftime('%_Y%m%d')
  end

  def get_financial_company_codes(target_date)
    codes = []
    num = 0
    loop do
      num += 1
      # ifisのサイトページの特性上、pageID=1000などでも最終ページが表示される
      # 対象日時の決算スケジュール予定の企業が変動するため、取得した企業コードを比較する
      site_page_a = load_uri(@uri + "&lst=#{target_date}&pageID=#{num}")
      codes_a = pick_company_code(site_page_a)

      site_page_b = load_uri(@uri + "&lst=#{target_date}&pageID=#{num + 1}")
      codes_b = pick_company_code(site_page_b)

      # 比較した企業コードが同一だった場合はこれまでのループで取得した企業コードを詰めてループを終了する
      if codes_a == codes_b
        codes << codes_a
        break codes.flatten.uniq
      else
        codes << (codes_a + codes_b)
      end
    end
  end

  def pick_company_code(site_page)
    page = Nokogiri::HTML.parse(site_page)
    page.css('#progress_list table tr').each_with_object([]) do |tr_elements, arry|
      td_element = tr_elements.at_css('td')
      next if td_element.blank?

      arry << td_element.text
    end
  end
end
