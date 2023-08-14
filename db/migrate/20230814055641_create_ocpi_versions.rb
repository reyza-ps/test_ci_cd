class CreateOcpiVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_versions, id: :uuid do |t|
      t.string :version, limit: 10, null: false
      t.string :url, limit: 255, null: false
      t.uuid :ocpi_credential_id, null: false

      t.timestamps
    end
  end
end
