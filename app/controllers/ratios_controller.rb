# Ratios controller
class RatiosController < ApplicationController
  include DateConcern

  def index
    date_from, date_to = extract_date_interval(params[:date_from], params[:date_to])
    @ratios = Ratio.by_currency_in_interval(date_from, date_to)

    render json: @ratios
  end
end
