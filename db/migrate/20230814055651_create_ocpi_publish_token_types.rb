class CreateOcpiPublishTokenTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_publish_token_types, id: :uuid do |t|
      t.string :token_type
      t.string :visual_number
      t.string :issuer
      t.uuid :group_id
      t.uuid :ocpi_location_id

      t.timestamps
    end
  end
end
