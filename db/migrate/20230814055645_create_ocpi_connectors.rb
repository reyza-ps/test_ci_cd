class CreateOcpiConnectors < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_connectors, id: :uuid do |t|
      t.uuid :ocpi_evse_id
      t.string :uid
      t.string :standard
      t.string :format
      t.string :power_type
      t.integer :max_voltage
      t.integer :max_amperage
      t.integer :max_electric_power
      t.string :tariff_ids, array: true, default: []
      t.string :terms_and_conditions
      t.datetime :last_updated

      t.timestamps
    end
  end
end
