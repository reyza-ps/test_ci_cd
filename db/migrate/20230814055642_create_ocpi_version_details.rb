class CreateOcpiVersionDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_version_details, id: :uuid do |t|
      t.uuid :ocpi_version_id

      t.timestamps
    end
  end
end
