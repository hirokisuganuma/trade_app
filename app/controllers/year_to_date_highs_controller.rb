class YearToDateHighsController < ApplicationController
  ACTION_NAME = 'yearToDateHigh'.freeze
  QUERY_PARAMS = '?market=all&term=daily'.freeze

  # 当日の年初来高値200件を取得する
  def index
    yahoo_finance_rank = Scrapes::YahooFinance::RankingService.new(ACTION_NAME, QUERY_PARAMS)
    @company_codes = yahoo_finance_rank.call
  end
end