class CreateOcpiEndpoints < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_endpoints, id: :uuid do |t|
      t.uuid :ocpi_version_detail_id
      t.string :identifier, null: false
      t.string :role, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
