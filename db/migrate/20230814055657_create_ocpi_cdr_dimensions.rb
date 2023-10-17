class CreateOcpiCdrDimensions < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_cdr_dimensions, id: :uuid do |t|
      t.string :dimension_type
      t.float :volume
      t.uuid :ocpi_charging_period_id

      t.timestamps
    end
  end
end
