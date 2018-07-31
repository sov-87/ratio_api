require "rails_helper"

RSpec.describe TinkoffRatios, :type => :request do

  # VCR recorded at 2018-07-30 14:26 UTC
  context 'success download' do
    let(:currency_rub) { create :currency_rub }
    let(:currency_usd) { create :currency_usd }

    it 'store ratios in empty db' do
      VCR.use_cassette('ratios_good') do
        TinkoffRatios.new.download_ratios
      end

      expect(Ratio.count).to eq(9)
    end

    it 'store ratios in db with ratios on request date' do
      ratio_day = Time.new(2018, 7, 30, 15)

      create(
        :ratio,
        from_currency_id: currency_usd.id,
        to_currency_id: currency_rub.id,
        buy: 61.55,
        sell: 64.05,
        ts: ratio_day)
      VCR.use_cassette('ratios_good') do
        TinkoffRatios.new.download_ratios
      end
      expect(Ratio.count).to eq(10)

      avg_ratio = AvgDayRatio.find_by(
        ts: ratio_day.utc.beginning_of_day,
        from_currency_id: currency_usd.id,
        to_currency_id: currency_rub.id
      )
      expect(avg_ratio).not_to be_nil
      expect(avg_ratio.buy).to eq(61.5)
      expect(avg_ratio.sell).to eq(64.0)
    end
  end

  context 'fail download' do

    it "don't store ratios in db" do
      VCR.use_cassette('ratios_bad') do
        expect{ TinkoffRatios.new.download_ratios }.to raise_error
      end
    end
  end
end
