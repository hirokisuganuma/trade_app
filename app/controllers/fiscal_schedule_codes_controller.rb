# frozen_string_literal: true

class FiscalScheduleCodesController < ApplicationController
  require 'open-uri'

  URL = 'https://kabuyoho.ifis.co.jp/index.php?sa=schedule'

  def index
    load_fiscal_schedule_codes
  end

  private

  def load_fiscal_schedule_codes
    target_date = Date.today.since(3.weeks).strftime('%_Y%m%d')
    codes = []
    num = 0
    loop do
      num += 1
      page_a = URI.parse(URL + "&lst=#{target_date}&pageID=#{num}").open('User-Agent' => 'Mozilla/5.0').read
      picked_codes_a = picke_codes(page_a)
      page_b = URI.parse(URL + "&lst=#{target_date}&pageID=#{num + 1}").open('User-Agent' => 'Mozilla/5.0').read
      picked_codes_b = picke_codes(page_b)

      if picked_codes_a == picked_codes_b
        codes << picked_codes_a
        @codes = codes.flatten.uniq
        break
      else
        codes << picked_codes_a + picked_codes_b
      end
    end
  end


  def picke_codes(html_page)
    doc = parse_html(html_page)
    doc.css('#progress_list table tr').each_with_object([]) do |attribute, arry|
      td_attribute = attribute.at_css('td')
      next if td_attribute.blank?
      arry << td_attribute.text
    end
  end

  def parse_html(html)
    Nokogiri::HTML.parse(html)
  end


end
