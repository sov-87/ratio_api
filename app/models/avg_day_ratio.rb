class AvgDayRatio < ApplicationRecord
  include Scopes::RatioConcern

  belongs_to :from_currency, class_name: 'Currency'
  belongs_to :to_currency, class_name: 'Currency'
end
