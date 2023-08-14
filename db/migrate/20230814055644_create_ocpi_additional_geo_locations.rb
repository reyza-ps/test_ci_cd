class CreateOcpiAdditionalGeoLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_additional_geo_locations, id: :uuid do |t|
      t.string :latitude
      t.string :longitude
      t.uuid :ocpi_display_text_id
      t.uuid :ocpi_location_id

      t.timestamps
    end
  end
end
