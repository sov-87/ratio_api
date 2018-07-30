# Base controller class
class RatiosController < ApplicationController
  def index
    date_from = params[:date_from] ? Time.parse(params[:date_from]) : Time.zone.now.to_date
    date_to = params[:date_to] ? Time.parse(params[:date_to]) : date_from + 1.day
    @ratios = Ratio
      .where(to_currency: Currency.find_by(name: 'RUB'))
      .where('ts >= ? AND ts < ?', date_from, date_to)

    render json: @ratios
  end
end
