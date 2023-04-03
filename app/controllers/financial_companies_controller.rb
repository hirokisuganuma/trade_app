class FinancialCompaniesController < ApplicationController
  ACTION_NAME = 'index.php'.freeze
  QUERY_PARAMS = '?sa=schedule'.freeze

  # 3週間後の決算予定の一覧を取得する
  def index
    financial_schedule_service = Scrapes::Ifis::FinancialScheduleService.new(ACTION_NAME, QUERY_PARAMS)
    @company_codes = financial_schedule_service.call
  end
end
