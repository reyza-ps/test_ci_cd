class CreateOcpiSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_sessions, id: :uuid do |t|
      t.string :uid
      t.string :country_code
      t.string :party_id
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.float :kwh
      t.string :auth_method
      t.string :authorization_reference
      t.string :location_id
      t.string :evse_uid
      t.string :connector_id
      t.string :meter_id
      t.string :currency
      t.string :status
      t.datetime :last_updated

      t.timestamps
    end
  end
end

