class Ratio < ApplicationRecord
  include Scopes::RatioConcern

  belongs_to :from_currency, class_name: 'Currency'
  belongs_to :to_currency, class_name: 'Currency'

  after_save :update_avg_day_ratio

  private
  def update_avg_day_ratio
    ratio_day = ts.beginning_of_day
    avg_day_ratio = AvgDayRatio.find_or_create_by(
      from_currency_id: from_currency_id,
      to_currency_id: to_currency_id,
      ts: ratio_day
    )
    today_ratios = Ratio
      .where(from_currency_id: from_currency_id, to_currency_id: to_currency_id)
      .where('ts >=? AND ts < ?', ratio_day, ratio_day + 1.day)
    avg_day_ratio.buy = today_ratios.pluck('avg(buy) avg_buy').first
    avg_day_ratio.sell = today_ratios.pluck('avg(sell) avg_sell').first

    avg_day_ratio.save
  end
end
