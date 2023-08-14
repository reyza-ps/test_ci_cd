class CreateOcpiCdrTariffRestrictions < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_cdr_tariff_restrictions, id: :uuid do |t|
      t.uuid :cdr_tariff_element_id
      t.string :start_time
      t.string :end_time
      t.string :start_date
      t.string :end_date
      t.float :min_kwh
      t.float :max_kwh
      t.float :min_current
      t.float :max_current
      t.float :min_power
      t.float :max_power
      t.integer :min_duration
      t.integer :max_duration
      t.string :day_of_week, array: true, default: []
      t.string :reservation
      t.timestamps
    end
  end
end
