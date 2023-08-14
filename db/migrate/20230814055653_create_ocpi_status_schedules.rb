class CreateOcpiStatusSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_status_schedules, id: :uuid do |t|
      t.datetime :period_begin
      t.datetime :period_end
      t.string :status
      t.uuid :ocpi_evse_id

      t.timestamps
    end
  end
end
