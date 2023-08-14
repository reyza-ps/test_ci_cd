class CreateOcpiRegularHours < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_regular_hours, id: :uuid do |t|
      t.uuid :ocpi_hour_id
      t.integer :weekday
      t.string :period_begin
      t.string :period_end

      t.timestamps
    end
  end
end
