class Currency < ApplicationRecord
  has_many :from_ratios, foreign_key: 'from_currency_id'
  has_many :to_ratios, foreign_key: 'to_currency_id'
end
