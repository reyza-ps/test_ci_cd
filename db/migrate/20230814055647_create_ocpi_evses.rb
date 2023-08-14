class CreateOcpiEvses < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_evses, id: :uuid do |t|
      t.uuid :ocpi_location_id
      t.string :uid
      t.string :evse_id
      t.string :status
      t.string :capabilities, array:true, default: []
      t.string :floor_level
      t.string :physical_reference
      t.string :parking_restrictions, array:true, default: []
      t.datetime :last_updated
      t.timestamps
    end
  end
end
