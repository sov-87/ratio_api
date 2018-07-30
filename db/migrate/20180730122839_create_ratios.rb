class CreateRatios < ActiveRecord::Migration[5.2]
  def change
    create_table :ratios do |t|
      t.references :from_currency, foreign_key: { to_table: :currencies }
      t.references :to_currency, foreign_key: { to_table: :currencies }
      t.decimal :buy
      t.decimal :sell
      t.timestamp :ts

      t.timestamps
    end
  end
end
