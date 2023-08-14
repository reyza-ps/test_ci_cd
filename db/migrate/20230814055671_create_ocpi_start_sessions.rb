class CreateOcpiStartSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_start_sessions, id: :uuid do |t|
      t.string :response_url
      t.uuid :ocpi_token_id
      t.string :location_id
      t.string :evse_uid
      t.string :connector_id
      t.string :authorization_reference
      t.timestamps
    end
  end
end
