class CreateOcpiClientInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_client_infos, id: :uuid do |t|
      t.string :country_code
      t.string :party_id
      t.string :role
      t.string :status
      t.datetime :last_updated

      t.timestamps
    end
  end
end
