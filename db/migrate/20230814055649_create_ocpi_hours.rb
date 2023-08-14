class CreateOcpiHours < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_hours, id: :uuid do |t|
      t.uuid :ocpi_location_id
      t.boolean :twentyfourseven

      t.timestamps
    end
  end
end
