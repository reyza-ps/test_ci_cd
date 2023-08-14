class CreateOcpiCdrs < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_cdrs, id: :uuid do |t|
      t.string :party_id, limit: 3, null: false
      t.string :country_code, limit: 2, null: false
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.string :session_id
      t.string :auth_method
      t.string :authorization_reference
      t.string :meter_id
      t.string :currency
      t.float :total_energy
      t.float :total_time
      t.float :total_parking_time
      t.string :remark
      t.string :invoice_reference_id
      t.boolean :credit
      t.integer :credit_reference_id
      t.boolean :home_charging_compensation
      t.datetime :last_updated, null: false
      t.string :uid

      t.timestamps
    end
  end
end
