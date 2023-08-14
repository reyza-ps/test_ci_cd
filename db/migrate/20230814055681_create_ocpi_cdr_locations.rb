class CreateOcpiCdrLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_cdr_locations, id: :uuid do |t|
      t.string :uid
      t.string :cdr_id
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :evse_uid
      t.string :evse_id
      t.string :connector_id
      t.string :connector_standard
      t.string :connector_format
      t.string :connector_power_type

      t.timestamps
    end
  end
end
