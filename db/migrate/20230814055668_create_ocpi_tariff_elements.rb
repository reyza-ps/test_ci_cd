class CreateOcpiTariffElements < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_tariff_elements, id: :uuid do |t|
      t.uuid :tariff_id
      t.timestamps
    end
  end
end
