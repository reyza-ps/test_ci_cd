class CreateOcpiPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_prices do |t|
      t.float :excl_vat
      t.float :incl_vat
      t.uuid :priceable_id
      t.string :priceable_type
      t.string :price_type

      t.timestamps
    end
  end
end