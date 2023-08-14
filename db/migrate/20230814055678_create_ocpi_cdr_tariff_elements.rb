class CreateOcpiCdrTariffElements < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_cdr_tariff_elements, id: :uuid do |t|
      t.uuid :cdr_tariff_id
      t.timestamps
    end
  end
end
