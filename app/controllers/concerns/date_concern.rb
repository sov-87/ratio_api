# common methods for date params
module DateConcern
  extend ActiveSupport::Concern

  def extract_date_interval(date_from_param, date_to_param)
    date_from = date_from_param ? Time.parse(date_from_param) : Time.zone.now.beginning_of_day
    date_to = date_to_param ? Time.parse(date_to_param) : date_from + 1.day

    return date_from, date_to
  end
end
