require "rails_helper"

RSpec.describe TinkoffRatios, :type => :request do

  # VCR recorded at 2018-07-30 14:26 UTC
  context 'success download' do
    it 'store ratios in empty db' do
      VCR.use_cassette('ratios_good') do
        TinkoffRatios.new.download_ratios
      end

      expect(Ratio.count).to eq(9)
    end

    it 'store ratios in db with ratios on request date' do
      ratio_day = Time.new(2018, 7, 30, 15)
      currency_rub = Currency.create(
        human_name: 'RUB',
        name: 'RUB',
        code: 643
      )
      currency_usd = Currency.create(
        human_name: 'USD',
        name: 'USD',
        code: 840
      )
      Ratio.create(
        from_currency: currency_usd,
        to_currency: currency_rub,
        buy: 60.25,
        sell: 62.1,
        ts: ratio_day
      )
      VCR.use_cassette('ratios_good') do
        TinkoffRatios.new.download_ratios
      end
      61.75
      sell	64.3
      expect(Ratio.count).to eq(9)

      avg_ratio = AvgDayRatio.find_by(
        day: ratio_day,
        from_currency_id: currency_usd.id,
        to_currency_id: currency_rub.id
      )
      expect(avg_ratio).to present
      exect(avg_ratio.buy).to eq(61)
      exect(avg_ratio.sell).to eq(63.2)
    end
  end

  context 'fail download' do

    it "don't store ratios in db" do
      VCR.use_cassette('ratios_bad') do
        TinkoffRatios.new.download_ratios

        expect(Ratio.count).to eq(1)
      end

    end
  end
end
