class CreateOcpiChargingPeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_charging_periods, id: :uuid do |t|
      t.datetime :start_date_time
      t.uuid :tariff_id
      t.uuid :charging_periodable_id
      t.string :charging_periodable_type

      t.timestamps
    end
  end
end
