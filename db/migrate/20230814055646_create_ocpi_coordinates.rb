class CreateOcpiCoordinates < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_geo_locations, id: :uuid do |t|
      t.string :latitude
      t.string :longitude
      t.uuid :coordinateable_id
      t.string :coordinateable_type
      t.timestamps
    end
  end
end
