# frozen_string_literal: true

require 'rails_helper'

RSpec.describe :FiscalScheduleCodesController, type: :request do
  context 'Response' do
    it 'レスポンスが200であること' do
      get fiscal_schedule_codes_path
      expect(response.status).to eq 200
    end
  end
end
