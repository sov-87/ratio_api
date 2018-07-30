class TinkoffRatios
  API_URL = ENV['RATIO_URL']

  def download_ratios
    response = RestClient.get API_URL

    data = ActiveSupport::JSON.decode(response.body.to_s)
    date = Time.at(data['payload']['lastUpdate']['milliseconds'].to_i/1000)
    data['payload']['rates'].select do |rate|
      rate['category'] == 'DepositPayments'
    end.each do |rate|
      fill_currencies([rate['fromCurrency'], rate['toCurrency']])
      ratio = Ratio.create(
        from_currency: Currency.find_by(name: rate['fromCurrency']['name']),
        to_currency: Currency.find_by(name: rate['toCurrency']['name']),
        buy: rate['buy'],
        sell: rate['sell'],
        ts: date
      )
    end
    logger.info response
  end

  private
  def logger
    @@logger ||= Logger.new(Rails.root.join("log", "ratio_downloader.log"))
  end

  def fill_currencies(currencies)
    currencies.each do |currency_data|
      currency = Currency.find_by(name: currency_data['name'])
      unless currency
        currency = Currency.create(
          human_name: currency_data['name'],
          name: currency_data['name'],
          code: currency_data['code']
        )
      end
    end
  end
end
