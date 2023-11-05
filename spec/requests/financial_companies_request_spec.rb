require 'rails_helper'

RSpec.describe :FinancialCompaniesController, type: :request do
  xcontext 'Response' do
    it 'レスポンスが200であること' do
      get financial_companies_path
      expect(response.status).to eq 200
    end
  end
end
