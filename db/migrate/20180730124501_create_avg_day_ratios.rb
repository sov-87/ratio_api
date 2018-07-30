class CreateAvgDayRatios < ActiveRecord::Migration[5.2]
  def change
    create_table :avg_day_ratios do |t|
      t.references :from_currency, foreign_key: { to_table: :currencies }
      t.references :to_currency, foreign_key: { to_table: :currencies }
      t.decimal :buy
      t.decimal :sell

      t.timestamp :day
    end
  end
end
