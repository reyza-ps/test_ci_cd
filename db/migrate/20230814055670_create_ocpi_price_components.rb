class CreateOcpiPriceComponents < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_price_components, id: :uuid do |t|
      t.uuid :tariff_element_id
      t.string :type
      t.float :price
      t.float :vat
      t.integer :step_size
      t.timestamps
    end
  end
end
