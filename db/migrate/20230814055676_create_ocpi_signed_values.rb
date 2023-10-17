class CreateOcpiSignedValues < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_signed_values do |t|
      t.string :signed_data_id
      t.text :nature
      t.text :plain_data
      t.text :blob_signed_data

      t.timestamps
    end
  end
end
