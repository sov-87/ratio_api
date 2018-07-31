class DownloadRatesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    TinkoffRatios.new.download_ratios
  end
end
