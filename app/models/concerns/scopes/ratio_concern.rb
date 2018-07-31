# common methods for date params
module Scopes
  module RatioConcern
    extend ActiveSupport::Concern

    class_methods do
      def by_currency_in_interval(date_from, date_to)
        where(to_currency: Currency.find_by(name: 'RUB'))
        .where('ts >= ? AND ts < ?', date_from, date_to)
        .order(:ts)
      end
    end
  end
end
