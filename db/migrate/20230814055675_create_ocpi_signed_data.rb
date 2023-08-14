class CreateOcpiSignedData < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_signed_data do |t|
      t.string :cdr_id
      t.string :encoding_method
      t.integer :encoding_method_version
      t.string :public_key
      t.string :url

      t.timestamps
    end
  end
end
