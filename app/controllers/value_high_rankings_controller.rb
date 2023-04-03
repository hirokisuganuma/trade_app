class ValueHighRankingsController < ApplicationController
  ACTION_NAME = 'tradingValueHigh'.freeze
  QUERY_PARAMS = '?market=all&term=daily'.freeze

  # 当日の売買代金ランキング200位までを取得する
  def index
    yahoo_finance_rank = Scrapes::YahooFinance::RankingService.new(ACTION_NAME, QUERY_PARAMS)
    @company_codes = yahoo_finance_rank.call
  end
end
