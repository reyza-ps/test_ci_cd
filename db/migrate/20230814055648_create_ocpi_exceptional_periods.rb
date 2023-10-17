class CreateOcpiExceptionalPeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_exceptional_periods, id: :uuid do |t|
      t.datetime :period_begin
      t.datetime :period_end
      t.uuid :ocpi_hour_id
      t.string :period_type
      t.timestamps
    end
  end
end
