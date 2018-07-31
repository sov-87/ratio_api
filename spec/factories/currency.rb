# Two main currencies
FactoryBot.define do
  factory :currency do
    factory :currency_rub do
      human_name 'RUB'
      name 'RUB'
      code 643
    end

    factory :currency_usd do
      human_name 'USD'
      name 'USD'
      code 840
    end
  end
end
