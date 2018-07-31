class RatioSerializer < ActiveModel::Serializer
  attributes :id, :buy, :sell

  attribute(:ts) { object.ts.strftime("%F %T") }
  attribute(:from_currency) { object.from_currency.name }
  attribute(:to_currency) { object.to_currency.name }
end
