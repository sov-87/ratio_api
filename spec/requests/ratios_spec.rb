require "rails_helper"

RSpec.describe 'Check rates response', :type => :request do
  let(:currency_rub) { create :currency_rub }
  let(:currency_usd) { create :currency_usd }
  let(:ratio_day) { Time.new(2018, 7, 30, 15) }

  before :each do
    create(
      :ratio,
      from_currency_id: currency_usd.id,
      to_currency_id: currency_rub.id,
      buy: 61.55,
      sell: 62.1,
      ts: ratio_day)
    create(
      :ratio,
      from_currency_id: currency_usd.id,
      to_currency_id: currency_rub.id,
      buy: 61.5,
      sell: 64.3,
      ts: ratio_day)
  end

  context 'success' do
    it 'show rates on day' do
      get '/ratios', params: {
        date_from: ratio_day,
        date_to: ratio_day + 1.day
      }
      expect(response.content_type).to eq("application/json")

      data = JSON.parse(response.body)
      expect(data.length).to eq(2)
    end
  end
end
