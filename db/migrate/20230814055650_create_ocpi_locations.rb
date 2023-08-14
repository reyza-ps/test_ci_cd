class CreateOcpiLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_locations, id: :uuid do |t|
      t.string :uid
      t.string :party_id
      t.string :country_code
      t.boolean :publish
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :parking_type
      t.uuid :operator_id
      t.uuid :sub_operator_id
      t.uuid :owner_id
      t.string :facilities, array:true, default: []
      t.string :time_zone
      t.boolean :charging_when_closed
      t.datetime :last_updated

      t.timestamps
    end
  end
end
