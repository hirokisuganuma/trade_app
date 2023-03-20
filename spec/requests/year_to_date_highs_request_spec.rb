require 'rails_helper'

RSpec.describe "YearToDateHighsController", type: :request do
  context 'Response' do
    it 'レスポンスが200であること' do
      get year_to_date_highs_path
      expect(response.status).to eq 200
    end
  end
end
