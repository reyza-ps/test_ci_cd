class CreateOcpiCdrTariffs < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_cdr_tariffs, id: :uuid do |t|
      t.string :party_id, limit: 3, null: false
      t.string :country_code, limit: 2, null: false
      t.string :currency
      t.string :type
      t.string :tariff_alt_url
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.datetime :last_updated, null: false
      t.string :uid
      t.string :cdr_id
      t.timestamps
    end
  end
end
