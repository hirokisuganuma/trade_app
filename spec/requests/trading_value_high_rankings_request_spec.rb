require 'rails_helper'

RSpec.describe "TradingValueHighRankingsController", type: :request do
  context 'Response' do
    it 'レスポンスが200であること' do
      get root_path
      expect(response.status).to eq 200
    end
  end
end
