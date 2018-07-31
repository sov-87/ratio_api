# Average Day Ratios controller
class AvgDayRatiosController < ApplicationController
  include DateConcern

  def index
    date_from, date_to = extract_date_interval(params[:date_from], params[:date_to])
    @avg_day_ratios = AvgDayRatio.by_currency_in_interval(date_from, date_to)

    render json: @avg_day_ratios, each_serializer: RatioSerializer
  end
end
