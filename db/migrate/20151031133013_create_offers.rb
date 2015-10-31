class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :shop
      t.decimal :price, precision: 10, scale: 2
      t.string :url

      t.timestamps null: false
    end
  end
end
