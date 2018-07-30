class CreateCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.string :human_name
      t.string :name
      t.integer :code

      t.timestamps
    end
  end
end
